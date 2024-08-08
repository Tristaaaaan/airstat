import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:flutter/material.dart';

class AirborneInfectionIsolationSavePage extends StatelessWidget {
  const AirborneInfectionIsolationSavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A.I.I."),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: const Center(
        child: Text("Save AII"),
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
              "assets/icons/Icon_IIR.png",
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                RegularButton(
                  buttonText: "Clear",
                  buttonKey: "aiiClear",
                  width: 100,
                  onTap: () {
                    informationSnackBar(context, Icons.warning,
                        "Please fill in all the fields");
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                RegularButton(
                  buttonText: "Save",
                  buttonKey: "aiiSave",
                  width: 100,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      informationSnackBar(context, Icons.warning,
                          "A.I.I. reading has been saved");
                    });
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
