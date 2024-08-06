import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:flutter/material.dart';

class Anteroom extends StatelessWidget {
  const Anteroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A.I.I."),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("Anteroom"),
                          SizedBox(
                            width: 210,
                            height: 210,
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/icons/anteroom_overlay.png",
                                  width: 200,
                                  height: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Anteroom"),
                    ],
                  ),
                ),
              ],
            )
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
              "assets/icons/Icon_IIR.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
              buttonText: "Next",
              buttonKey: "boothNext",
              width: 100,
              onTap: () {
                informationSnackBar(
                    context, Icons.warning, "Please fill in all the fields");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Anteroom();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
