import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/dialog/confirmation_dialog.dart';
import 'package:airstat/main/booth/booth_page.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoothSaveData extends ConsumerWidget {
  const BoothSaveData({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveDataServices = ref.watch(saveDataServicesProvider);
    final TextEditingController fileNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booth"),
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
              "assets/icons/Special_DD.png",
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                RegularButton(
                  buttonKey: "boothDiscard",
                  buttonText: "Discard",
                  width: 100,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          confirm: () async {
                            print("OKAY");
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
                  buttonKey: "randomSave",
                  buttonText: "Save",
                  width: 100,
                  onTap: () async {
                    if (fileNameController.text.isEmpty) {
                      informationSnackBar(context, Icons.warning,
                          "Kindly enter the file name to proceed");
                    } else {
                      print("SAVE DATA");
                      final date = DateTime.now();

                      const data = '312123';
                      // // refs
                      final fileList = ref.read(fileListProvider.notifier);

                      await saveDataServices.writeContent(
                        fileNameController.text,
                        ref.watch(unitValueProvider),
                        'booth',
                        date,
                        date,
                        data.toString(),
                        ref.watch(generalSamplingValueProvider),
                        ref.watch(generalDelayValueProvider),
                        ref.watch(zoneValueProvider), // id4
                        ref.watch(siteValueProvider), // id 1
                        ref.watch(shopValueProvider), // id 2
                        ref.watch(lineValueProvider), // id 3
                      );

                      // Refresh the file list after saving the new file
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.check, "File has been saved");

                        fileList.refresh();

                        // tobeSaved.clearData();
                        // randomReading.clearData();
                        // fileNameController.text = "";
                        // dataCount.state = 0;
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
