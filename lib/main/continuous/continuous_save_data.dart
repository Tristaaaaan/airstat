import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContinuousSaveData extends ConsumerWidget {
  final String zoneId;
  const ContinuousSaveData({
    super.key,
    required this.zoneId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveDataServices = ref.watch(saveDataServicesProvider);
    final TextEditingController fileNameController = TextEditingController();
    final serialData = ref.watch(serialDataProvider);
    final stopWatch = ref.watch(stopWatchTimerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Continuous"),
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
            RegularButton(
              buttonKey: "continuousDiscard",
              buttonText: "Discard",
              width: 100,
              onTap: () {},
            ),
            RegularButton(
              buttonKey: "continuousSave",
              buttonText: "Save",
              width: 100,
              onTap: () async {
                if (fileNameController.text.isEmpty && serialData.isNotEmpty) {
                  informationSnackBar(context, Icons.warning,
                      "Kindly enter the file name to proceed");
                } else {
                  final date = DateTime.now();

                  final data = ref.watch(toBeSavedDataProvider);

                  // Refresh the file list after saving the new file
                  ref.read(fileListProvider.notifier).refresh();

                  await saveDataServices.writeContent(
                    fileNameController.text,
                    ref.watch(unitValueProvider),
                    'continuous',
                    date,
                    date,
                    data.toString(),
                    ref.watch(generalSamplingValueProvider),
                    ref.watch(generalDelayValueProvider),
                    zoneId,
                    "--.-",
                    "--.-",
                    "--.-",
                    "--.-",
                    "--.-",
                    "--.-",
                    '--.-',
                    '--.-',
                    '--.-',
                    '--.-',
                    '--.-',
                    '--.-',
                    '--.-',
                    '--.-',
                    ref.watch(userNameValueProvider),
                  );
                  ref.read(serialDataProvider.notifier).clearData();
                  ref.read(toBeSavedDataProvider.notifier).clearData();
                  stopWatch.onResetTimer();
                  // Refresh the file list after saving the new file
                  if (context.mounted) {
                    informationSnackBar(
                        context, Icons.check, "File has been saved");
                    ref.read(fileListProvider.notifier).refresh();

                    Navigator.pop(context);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
