import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/main/aii/save_aii.dart';
import 'package:flutter/material.dart';

class PatientRoom extends StatelessWidget {
  const PatientRoom({super.key});

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
        child: Text("Patient Room"),
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
                  buttonText: "Read",
                  buttonKey: "aiiRead",
                  withLoading: true,
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
                  buttonText: "Next",
                  buttonKey: "aiiNext",
                  width: 100,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AirborneInfectionIsolationSavePage(),
                      ),
                    );
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
