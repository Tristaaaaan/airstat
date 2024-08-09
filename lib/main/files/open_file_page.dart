import 'dart:convert';

import 'package:airstat/main/files/file_page.dart';
import 'package:airstat/main/settings/space_defintion_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final pageFileNameProvider = StateProvider<String>((ref) {
  return '';
});

final pageReadingModeProvider = StateProvider<String>((ref) {
  return '';
});

class OpenFiles extends HookConsumerWidget {
  const OpenFiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();
    final selectedFileContent = ref.watch(fileContentProvider);

    void initializePageName() {
      final String initialKey = selectedFileContent.keys.first;
      final String initialValue = selectedFileContent[initialKey]!;

      // Extract and update the filename safely
      RegExp fileNameRegExp = RegExp(r'filename: ([^,]+)');
      Match? fileNameMatch = fileNameRegExp.firstMatch(initialValue);
      // Extract and update the filename safely
      RegExp readingModeRegExp = RegExp(r'mode:\s*(\S+),');
      Match? readingModeMatch = readingModeRegExp.firstMatch(initialValue);

      Future.delayed(const Duration(milliseconds: 100), () {
        if (readingModeMatch != null && fileNameMatch != null) {
          String filename = fileNameMatch.group(1)!;
          String readingMode = readingModeMatch.group(1)!;
          ref.read(pageFileNameProvider.notifier).state = filename;
          ref.read(pageReadingModeProvider.notifier).state = readingMode;
        } else {
          print("Filename or reading mode not found");
        }
      });
    }

    useEffect(() {
      initializePageName();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
      ),
      body: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(), // or ClampingScrollPhysics()
        itemCount: selectedFileContent.length,
        onPageChanged: (index) {
// Get the key at the current index
          final String key = selectedFileContent.keys.elementAt(index);
          // Get the value associated with the key
          final String value = selectedFileContent[key]!;
          print("Value: $value");

          // Extract and update the filename safely
          RegExp fileNameRegExp = RegExp(r'filename: ([^,]+)');
          Match? fileNameMatch = fileNameRegExp.firstMatch(value);
          RegExp readingModeRegExp = RegExp(r'mode:\s*(\S+),');
          Match? readingModeMatch = readingModeRegExp.firstMatch(value);

          Future.delayed(Duration.zero, () {
            if (fileNameMatch != null && readingModeMatch != null) {
              String filename = fileNameMatch.group(1)!;
              String readingMode = readingModeMatch.group(1)!;
              ref.read(pageFileNameProvider.notifier).state = filename;
              ref.read(pageReadingModeProvider.notifier).state = readingMode;
            } else {
              print("Filename not found");
            }
          });
        },

        itemBuilder: (context, index) {
          // Get the key at the current index
          final String key = selectedFileContent.keys.elementAt(index);
          // Get the value associated with the key
          final String value = selectedFileContent[key]!;
          //READING MODE

          print("value: $value");
          RegExp regExp = RegExp(r'mode:\s*(\S+),');
          Match? modeMatch = regExp.firstMatch(value);
          String? mode;
          if (modeMatch != null) {
            mode = modeMatch.group(1)!;
            print('Extracted mode: $mode');
          } else {
            print('Mode not found');
          }

          List<List<dynamic>> dataList = [];
          if (mode == 'random' || mode == 'continuous') {
            print("Mode: $modeMatch");
            final RegExp dataRegExp = RegExp(r'data:\s*(\[\[.*?\]\])');
            String data = '';
            // Search for the pattern in the csvContent
            final dataMatch = dataRegExp.firstMatch(value);
            // Convert string to List<List<dynamic>>
            print("DATA: $dataMatch");
            if (dataMatch != null) {
              // Extract the data value from the match
              data = dataMatch.group(1)!;
            } else {
              print("Data field not found.");
            }

            try {
              dataList = List<List<dynamic>>.from(
                json.decode(data).map((item) => List<dynamic>.from(item)),
              );
            } catch (e) {
              print("Error decoding data: $e");
            }
          } else if (mode == 'booth') {
            String boothReading = '';
            String exitSilhouette = '';
            String entranceSilhouette = '';

            // Regular expression to extract the data arrays
            RegExp boothReadingRegExp =
                RegExp(r'booth_reading:\s*(\[\[.*?\]\](?=,|]))', dotAll: true);
            RegExp exitSilhouetteRegExp = RegExp(
                r'exit_silhouette:\s*(\[\[.*?\]\](?=,|]))',
                dotAll: true);
            RegExp entranceSilhouetteRegExp = RegExp(
                r'entrance_silhouette:\s*(\[\[.*?\]\](?=,|]))',
                dotAll: true);

            // Extract the booth_reading data
            Match? boothReadingMatch = boothReadingRegExp.firstMatch(value);
            if (boothReadingMatch != null) {
              boothReading = boothReadingMatch.group(1)!;
            } else {
              print('Booth Reading not found');
            }

            // Extract the exit_silhouette data
            Match? exitSilhouetteMatch = exitSilhouetteRegExp.firstMatch(value);
            if (exitSilhouetteMatch != null) {
              exitSilhouette = exitSilhouetteMatch.group(1)!;
            } else {
              print('Exit Silhouette not found');
            }

            // Extract the entrance_silhouette data
            Match? entranceSilhouetteMatch =
                entranceSilhouetteRegExp.firstMatch(value);
            if (entranceSilhouetteMatch != null) {
              entranceSilhouette = entranceSilhouetteMatch.group(1)!;
            } else {
              print('Entrance Silhouette not found');
            }

            // ENTRANCE SILHOUETTE
            String entranceSilhouetteDataString =
                entranceSilhouette.substring(1, entranceSilhouette.length - 1);

            // Split string into individual rows based on the delimiter
            List<String> entranceSilhouetteRows = entranceSilhouetteDataString
                .split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

            // Process each row
            List<List<dynamic>> entranceSilhouetteList =
                entranceSilhouetteRows.map((row) {
              // Remove potential brackets and trim spaces
              row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

              // Split row into cells
              List<dynamic> cells =
                  row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                // Remove any extra spaces
                cell = cell.trim();

                // Convert empty strings to null
                if (cell.isEmpty) {
                  return null;
                }

                // Convert numbers to int
                var number = int.tryParse(cell);
                if (number != null) {
                  return number;
                }

                // Return the cell as is for strings
                return cell;
              }).toList();

              return cells;
            }).toList();

            // BOOTH READING
            String boothReadingDataString =
                boothReading.substring(1, boothReading.length - 1);

            // Split string into individual rows based on the delimiter
            List<String> boothReadingRows = boothReadingDataString
                .split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

            // Process each row
            List<List<dynamic>> boothReadingList = boothReadingRows.map((row) {
              // Remove potential brackets and trim spaces
              row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

              // Split row into cells
              List<dynamic> cells =
                  row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                // Remove any extra spaces
                cell = cell.trim();

                // Convert empty strings to null
                if (cell.isEmpty) {
                  return null;
                }

                // Convert numbers to int
                var number = int.tryParse(cell);
                if (number != null) {
                  return number;
                }

                // Return the cell as is for strings
                return cell;
              }).toList();

              return cells;
            }).toList();

            // EXIT SILHOUETTE
            String dataString =
                exitSilhouette.substring(1, exitSilhouette.length - 1);

            // Split string into individual rows based on the delimiter
            List<String> rowss =
                dataString.split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

            // Process each row
            List<List<dynamic>> exitSilhouetteList = rowss.map((row) {
              // Remove potential brackets and trim spaces
              row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

              // Split row into cells
              List<dynamic> cells =
                  row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                // Remove any extra spaces
                cell = cell.trim();

                // Convert empty strings to null
                if (cell.isEmpty) {
                  return null;
                }

                // Convert numbers to int
                var number = int.tryParse(cell);
                if (number != null) {
                  return number;
                }

                // Return the cell as is for strings
                return cell;
              }).toList();

              return cells;
            }).toList();

            for (var data in entranceSilhouetteList) {
              dataList.add(
                [
                  data[0],
                  data[2] ?? '--.-',
                  data[3] ?? '--.-',
                ],
              );
            }
            for (var data in boothReadingList) {
              dataList.add(
                [
                  data[0],
                  data[2] ?? '--.-',
                  data[3] ?? '--.-',
                ],
              );
            }

            for (var data in exitSilhouetteList) {
              dataList.add(
                [
                  data[0],
                  data[2] ?? '--.-',
                  data[3] ?? '--.-',
                ],
              );
            }
          }

          return Column(
            children: [
              Row(
                children: [
                  IDHolder(
                    definition: "DataPoint",
                    textColor: Theme.of(context).colorScheme.inversePrimary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IDHolder(
                    definition: "Downdraft",
                    textColor: Theme.of(context).colorScheme.inversePrimary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IDHolder(
                    definition: "CrossDraft",
                    textColor: Theme.of(context).colorScheme.inversePrimary,
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: dataList.length,
                    itemBuilder: (context, dataIndex) {
                      final dataRow = dataList[dataIndex];
                      return Row(
                        children: [
                          IDHolder(
                            definition: mode == "random"
                                ? "Measurement ${(dataRow[0] + 1).toString()}"
                                : dataRow[0].toString(),
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IDHolder(
                            definition: dataRow[1].toString(),
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IDHolder(
                            definition: dataRow[1].toString(),
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icons/Icon_files_orange.png",
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ref.watch(pageFileNameProvider),
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        ref.watch(pageReadingModeProvider) == "random"
                            ? "Random"
                            : ref.watch(pageReadingModeProvider) == "booth"
                                ? "Booth"
                                : ref.watch(pageReadingModeProvider) ==
                                        "continuous"
                                    ? "Continuous"
                                    : ref.watch(pageReadingModeProvider) ==
                                            "aii"
                                        ? "A.I.I."
                                        : ref.watch(pageReadingModeProvider) ==
                                                "or"
                                            ? "O.R."
                                            : "3D Map",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SmoothPageIndicator(
              controller: controller,
              count: selectedFileContent.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Theme.of(context).colorScheme.secondary,
                activeDotColor: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
