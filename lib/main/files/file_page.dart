import 'dart:io';

import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/functions/file_size_getter.dart';
import 'package:airstat/permission/permission_handlers.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fileContentProvider =
    StateNotifierProvider<FileContentNotifier, Map<String, String>>(
  (ref) => FileContentNotifier(),
);

class FileContentNotifier extends StateNotifier<Map<String, String>> {
  FileContentNotifier() : super({});

  void setContent(String filePath, String content) {
    state = {...state, filePath: content};
  }

  void removeContent(String filePath) {
    final newState = {...state};
    newState.remove(filePath);
    state = newState;
  }

  void clearContent() {
    state = {};
  }
}

class FilePage extends ConsumerWidget {
  const FilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveDataServices = ref.watch(saveDataServicesProvider);
    final files = ref.watch(fileListProvider);
    final selectedFiles = ref.watch(selectedFilesProvider);
    final selectedFileContent = ref.watch(fileContentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          if (files.isEmpty)
            const Expanded(
              child: Center(
                child: Text("No files found"),
              ),
            ),
          if (files.isNotEmpty)
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
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {
                        final filePath = files[index];
                        ref
                            .read(selectedFilesProvider.notifier)
                            .toggleSelection(filePath);

                        final isSelected =
                            ref.read(selectedFilesProvider).contains(filePath);

                        if (isSelected) {
                          final fileContent =
                              await File(filePath).readAsString();
                          ref
                              .read(fileContentProvider.notifier)
                              .setContent(filePath, fileContent);
                          print(fileContent);
                        } else {
                          ref
                              .read(fileContentProvider.notifier)
                              .removeContent(filePath);
                        }
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isSelected
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.background,
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
                buttonKey: "uploadButton",
                width: double.infinity,
                onTap: () async {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Open",
                buttonKey: "openButton",
                width: double.infinity,
                onTap: () {
                  for (var filePath in selectedFileContent.keys) {
                    final content = selectedFileContent[filePath];
                    print('Content of $filePath: $content');
                  }
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Delete",
                buttonKey: "deleteButton",
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
                buttonKey: "exportButton",
                width: double.infinity,
                onTap: () async {
                  bool permission = await checkPermissionStatus();
                  print("Permission: $permission");
                  if (permission) {
                    print("Exporting...");
                    await saveDataServices.exportCSV(ref);
                    ref.read(selectedFilesProvider.notifier).clearSelection();
                  } else {
                    await requestStoragePermissions();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
