import 'dart:io';

import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/functions/file_size_getter.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilePage extends ConsumerWidget {
  const FilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveDataServices = ref.watch(saveDataServicesProvider);
    final files = ref.watch(fileListProvider);
    final selectedFiles = ref.watch(selectedFilesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = File(files[index]);
                final fileSize = formatFileSize(file.lengthSync());
                final isSelected = selectedFiles.contains(files[index]);
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    ref
                        .read(selectedFilesProvider.notifier)
                        .toggleSelection(files[index]);
                    final fileContent = await File(files[index]).readAsString();
                    print(fileContent);
                  },
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(5),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected ? Colors.grey : Colors.white,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/icons/Icon_files_orange.png",
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  files[index]
                                      .split('/')
                                      .last, // Display the file name
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                fileSize,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RegularButton(
                buttonText: "Upload",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Open",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Delete",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {
                  ref
                      .read(fileListProvider.notifier)
                      .deleteFiles(selectedFiles);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Export",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () async {
                  // Assuming saveDataServices is an instance of a class managing file operations
                  await saveDataServices.writeContent();
                  // Refresh the file list after saving the new file
                  ref.read(fileListProvider.notifier).refresh();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}