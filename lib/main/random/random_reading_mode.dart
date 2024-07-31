import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/random/random_reading_page.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RandomReadingMode extends ConsumerWidget {
  RandomReadingMode({super.key});

  final TextEditingController zoneIdController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random"),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: Center(
        child: Column(
          children: [
            RegularTextField(
              category: "Zone ID",
              controller: zoneIdController,
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
              "assets/icons/Icon_random_orange.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
                buttonText: "Next",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.primary,
                width: 100,
                onTap: () {
                  if (zoneIdController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RandomReadingPage(
                          zoneId: zoneIdController.text,
                        ),
                      ),
                    );

                    ref.read(randomReadingDataHolder.notifier).clearData();
                    ref.read(dataCountProvider.notifier).state = 0;
                    ref.read(serialDataProvider.notifier).clearData();
                  } else {
                    informationSnackBar(context, Icons.warning,
                        "To proceed, kindly insert a zone ID");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
