import 'dart:convert';

import 'package:airstat/main/files/file_page.dart';
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
          List<List<dynamic>> dataList = [];
          try {
            dataList = List<List<dynamic>>.from(
              json.decode(data).map((item) => List<dynamic>.from(item)),
            );
          } catch (e) {
            print("Error decoding data: $e");
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, dataIndex) {
                    final dataRow = dataList[dataIndex];
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              "Measurement ${(dataRow[0] + 1).toString()}",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dataRow[1].toString(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dataRow[2].toString(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: SizedBox(
        height: 80,
        child: SmoothPageIndicator(
          controller: controller,
          count: selectedFileContent.length,
          effect: WormEffect(
            dotHeight: 10,
            dotWidth: 10,
            dotColor: Theme.of(context).colorScheme.secondary,
            activeDotColor: Theme.of(context).colorScheme.tertiaryContainer,
          ),
        ),
      ),
    );
  }
}
