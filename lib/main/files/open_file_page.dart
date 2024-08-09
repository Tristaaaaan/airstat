import 'dart:convert';

import 'package:airstat/main/files/file_page.dart';
import 'package:airstat/main/settings/space_defintion_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OpenFiles extends ConsumerWidget {
  const OpenFiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();
    final selectedFileContent = ref.watch(fileContentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
      ),
      body: PageView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(), // or ClampingScrollPhysics()
        itemCount: selectedFileContent.length,
        onPageChanged: (value) {},

        itemBuilder: (context, index) {
          // Get the key at the current index
          final String key = selectedFileContent.keys.elementAt(index);
          // Get the value associated with the key
          final String value = selectedFileContent[key]!;
          // Regular expression to extract the mode
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
          } else {
            print("Mode not found");
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
                                : "DataPoint ${(dataRow[0] + 1).toString()}",
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
                const SizedBox(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Filename",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Reading Mode",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
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
