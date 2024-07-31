import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/dialog/confirmation_dialog.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/main/random/random_reading_page.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomSaveData extends ConsumerWidget {
  final String zoneId;
  const RandomSaveData({
    super.key,
    required this.zoneId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveDataServices = ref.watch(saveDataServicesProvider);
    final TextEditingController fileNameController = TextEditingController();

    final stopWatch = ref.watch(stopWatchTimerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random"),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: Center(
        child: Column(
          children: [
            RegularTextField(
              category: "File Name",
              controller: fileNameController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/icons/Icon_continuous_orange.png",
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                RegularButton(
                  buttonText: "Discard",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          confirm: () async {
                            print("OKAY");
                            ref
                                .read(randomReadingDataHolder.notifier)
                                .clearData();
                            Navigator.of(context).pop();
                          },
                          content:
                              "By tapping \"Yes\", the current obtained data will be discarded.",
                          title: "Confirmation",
                          type: "Yes",
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                RegularButton(
                  buttonText: "Save",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () async {
                    if (fileNameController.text.isEmpty) {
                      informationSnackBar(context, Icons.warning,
                          "Kindly enter the file name to proceed");
                    } else {
                      final date = DateTime.now();
                      final data = ref.watch(toBeSavedDataProvider);

                      // refs
                      final fileList = ref.read(fileListProvider.notifier);
                      final randomReading =
                          ref.read(randomReadingDataHolder.notifier);
                      final tobeSaved =
                          ref.read(toBeSavedDataProvider.notifier);
                      final dataCount = ref.read(dataCountProvider.notifier);
                      await saveDataServices.writeContent(
                        fileNameController.text,
                        ref.watch(unitValueProvider),
                        'random',
                        date,
                        date,
                        data.toString(),
                        ref.watch(generalSamplingValueProvider),
                        ref.watch(generalDelayValueProvider),
                        zoneId,
                      );

                      // Refresh the file list after saving the new file
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.check, "File has been saved");

                        fileList.refresh();
                        stopWatch.onResetTimer();
                        tobeSaved.clearData();
                        randomReading.clearData();
                        fileNameController.text = "";
                        dataCount.state = 0;
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
