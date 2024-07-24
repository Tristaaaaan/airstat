import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// Controls the StopWatchTimer package for each sensor
final stopWatchTimerProvider = StateProvider<StopWatchTimer>((ref) {
  return StopWatchTimer();
});

final isReadingProvider = StateProvider<bool>((ref) {
  return false;
});

class ContinuosReadingData extends ConsumerWidget {
  const ContinuosReadingData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AudioPlayer player = AudioPlayer();
    final stopWatchTimer = ref.watch(stopWatchTimerProvider);
    final serialData = ref.watch(serialDataProvider);

    final isReading = ref.watch(isReadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Continuous"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/icon_dd1.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          serialData.isEmpty
                              ? "--.-"
                              : secondValue(serialData.last),
                          style: const TextStyle(fontSize: 120),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/icon_cd1.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          serialData.isEmpty
                              ? "--.-"
                              : thirdValue(serialData.last),
                          style: const TextStyle(fontSize: 120),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: StreamBuilder<int>(
                  stream: stopWatchTimer.rawTime,
                  initialData: 0,
                  builder: (context, snap) {
                    final value = snap.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!);
                    return Column(
                      children: <Widget>[
                        Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ),
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
            Row(
              children: [
                RegularButton(
                    buttonText: "Stop",
                    textColor: Theme.of(context).colorScheme.background,
                    backgroundColor: !isReading
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                    width: 100,
                    onTap: !isReading
                        ? () {}
                        : () async {
                            ref.read(isReadingProvider.notifier).state = false;
                            stopWatchTimer.onStopTimer();
                            await stopContinuousData(ref);
                            if (context.mounted) {
                              informationSnackBar(context, Icons.info,
                                  "Data reading has stopped.");
                            }
                          }),
                const SizedBox(width: 10),
                RegularButton(
                  buttonText: "Read",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: isReading
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: isReading
                      ? () {}
                      : () async {
                          ref.read(isReadingProvider.notifier).state = true;
                          await player.play(AssetSource('audios/beep-09.wav'),
                              volume: 1);
                          stopWatchTimer.onResetTimer();

                          await readContinuousData(ref);
                          stopWatchTimer.onStartTimer();
                          if (context.mounted) {
                            informationSnackBar(context, Icons.info,
                                "Data reading has started.");
                          }
                        },
                ),
                const SizedBox(width: 10),
                RegularButton(
                  buttonText: "Save",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String removeTrailingZeroes(String value) {
  // Remove trailing zeroes
  return value.replaceFirst(RegExp(r'^0+'), '');
}

String secondValue(String data) {
  List<String> parts = data.split(','); // Split the string by commas
  String secondValue = parts[1].trim();

  if (secondValue.isEmpty) {
    return "--.-";
  } else {
    // Remove trailing zeroes
    String cleanedValue = removeTrailingZeroes(secondValue);
    // Assuming you want to transform the cleaned value into a negative number
    String transformedValue = (-int.parse(cleanedValue)).toString();
    return transformedValue;
  }
}

String thirdValue(String data) {
  List<String> parts = data.split(','); // Split the string by commas
  String thirdValue = parts[2].trim();

  if (thirdValue.isEmpty) {
    return "--.-";
  } else {
    return removeTrailingZeroes(thirdValue);
  }
}
