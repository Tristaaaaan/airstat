import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/settings_container.dart';
import 'package:airstat/components/container/settings_container_one.dart';
import 'package:airstat/components/container/settings_container_two.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/permission/permission_handlers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usb_serial/usb_serial.dart';

class Settings extends ConsumerWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final serialComm = ref.watch(serialCommunicationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SettingsContainer(category: "General Sampling"),
            SettingsContainer(category: "Silhouette / Vents Sampling"),
            SettingsContainer(category: "General Delay"),
            SettingsContainer(category: "Silhouette / Vents Delay"),
            SettingsContainerTwo(category: "Units"),
            SettingsContainerOne(category: "Spaces Configuration"),
            RegularTextField(category: "User / Test ID", hinttext: "username"),
            RegularTextField(category: "Cloud Folder", hinttext: "folder name"),
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
            Icon(
              Icons.settings,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            RegularButton(
              buttonText: "Save",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () async {
                var status = await checkPermission();

                if (!status) {
                  await requestPermissions();
                } else {
                  List<UsbDevice> serialList = await UsbSerial.listDevices();
                  print(serialList);
                  print(serialList);
                  if (serialList.isEmpty) {
                    print("Serial List: $serialList");
                    print("Serial List is empty");
                    if (context.mounted) {
                      informationSnackBar(
                          context, Icons.error, "There is no available ports");
                    }
                  } else {
                    print("Serial List: $serialList");
                    print("Serial List is empty");
                    if (context.mounted) {
                      informationSnackBar(context, Icons.check,
                          "There are available ports. The available ports are: $serialList");
                    }
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
