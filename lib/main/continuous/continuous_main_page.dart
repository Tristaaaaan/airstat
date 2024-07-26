import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContinuousReadingMode extends ConsumerWidget {
  const ContinuousReadingMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController zoneIdController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Continuous"),
      ),
      body: Center(
        child: Column(
          children: [
            RegularTextField(
              category: "Zone ID",
              controller: zoneIdController,
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
              buttonText: "Next",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () {
                if (zoneIdController.text.isEmpty) {
                  informationSnackBar(context, Icons.warning,
                      "To proceed, kindly insert a zone ID");
                } else {
                  ref.read(serialDataProvider.notifier).clearData();

                  ref.read(toBeSavedDataProvider.notifier).clearData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContinuosReadingData(
                        zoneId: zoneIdController.text,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
