import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/booth/dynamictables/booth_reading_dynamic_table.dart';
import 'package:airstat/main/booth/dynamictables/exit_silhoutte_dynamic_table.dart';
import 'package:airstat/main/booth/exit_silhouette_page.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoothReading extends ConsumerWidget {
  const BoothReading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booth",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "Reading",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              BoothReadingDynamicTable(rows: 3, columns: 5),
            ],
          ),
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
                  buttonText: "Read",
                  buttonKey: "boothRead",
                  width: 100,
                  withLoading: true,
                  onTap: () async {
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", true);

                    final List<String> values =
                        await readBoothData(ref, ref.watch(unitValueProvider));

                    final selectedBox =
                        ref.read(selectedBoothReadingBoxProvider);
                    final row = selectedBox['selectedBox']['row'];
                    final col = selectedBox['selectedBox']['col'];

                    // Check if the selected cell already has a value
                    if (row != null &&
                        col != null &&
                        ref
                                .read(selectedBoothReadingBoxProvider.notifier)
                                .getValue(row, col) !=
                            null) {
                      ref
                          .read(isLoadingProvider.notifier)
                          .setLoading("boothRead", false);
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.info, "Box already filled");
                      }
                      return; // Exit the function if the cell already has a value
                    } else {
                      ref
                          .read(selectedBoothReadingBoxProvider.notifier)
                          .updateSelectedBoxValue(values.toString());
                    }
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", false);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                RegularButton(
                  buttonText: "Next",
                  buttonKey: "boothNext",
                  width: 100,
                  onTap: () {
                    ref
                        .read(selectedExitSilhouetteBoxProvider.notifier)
                        .clearValues();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ExitSilhouette();
                        },
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
