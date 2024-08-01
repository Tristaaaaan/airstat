import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/measure_random_reading_container.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/main/random/random_save_data.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the provider
final randomReadingDataHolder =
    StateNotifierProvider<RandomDataNotifier, List<String>>((ref) {
  return RandomDataNotifier();
});

// StateNotifier implementation
class RandomDataNotifier extends StateNotifier<List<String>> {
  RandomDataNotifier() : super([]);

  void addData(String data) {
    state = [...state, data];
  }

  void clearData() {
    state = [];
  }
}

class RandomReadingPage extends ConsumerWidget {
  final String zoneId;
  RandomReadingPage({super.key, required this.zoneId});

  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomReadingData = ref.watch(randomReadingDataHolder);
    final isReading = ref.watch(isReadingProvider);
    print("randomReadingData: $randomReadingData");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random"),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Serial Data: ${ref.watch(serialDataProvider)}"),
            randomReadingData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: randomReadingData.length,
                      itemBuilder: (context, index) {
                        // Remove brackets and split the string to get the values
                        List<String> data = randomReadingData[index]
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .split(',');

                        // Convert the split strings to integers
                        int downDraft = int.parse(data[0].trim());
                        int crossDraft = int.parse(data[1].trim());
                        return MeasureReadingRandom(
                          label: "Measurement ${index + 1}",
                          downDraft: downDraft.toString(),
                          crossDraft: crossDraft.toString(),
                        );
                      },
                    ),
                  )
                : const Text("No Data"),
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
                  buttonText: "Read",
                  textColor: randomReadingData.isEmpty
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.background,
                  backgroundColor: randomReadingData.isEmpty
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: isReading
                      ? () {}
                      : () async {
                          final reading = ref.read(isReadingProvider.notifier);

                          final serialData =
                              ref.read(serialDataProvider.notifier);
                          // ORIGINAL CODE
                          reading.state = true;
                          await player.play(AssetSource('audios/beep-09.wav'),
                              volume: 1);

                          serialData.clearData();

                          await readRandomData(
                            ref,
                            ref.watch(unitValueProvider),
                          );

                          if (context.mounted) {
                            informationSnackBar(
                                context, Icons.info, "Acquisition Started.");

                            reading.state = false;
                          }

                          // Random random = Random();
                          // String data =
                          //     '[${random.nextInt(100)}, ${random.nextInt(100)}]';
                          // ref.read(randomReadingDataHolder.notifier).addData(data);

                          // print("Random Data: ${ref.watch(randomReadingDataHolder)}");
                        },
                ),
                const SizedBox(width: 10),
                RegularButton(
                    buttonText: "Save",
                    textColor: randomReadingData.isEmpty
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Theme.of(context).colorScheme.background,
                    backgroundColor: randomReadingData.isEmpty
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    width: 100,
                    onTap: randomReadingData.isEmpty
                        ? () {}
                        : () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RandomSaveData(
                                zoneId: zoneId,
                              );
                            }));
                          }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
