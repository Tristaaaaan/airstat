import 'dart:async';

import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/main/continuous/continuous_save_data.dart';
import 'package:airstat/models/serial_data_model.dart';
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

final secondValueProvider = StateProvider<String>((ref) {
  return "";
});

final thirdValueProvider = StateProvider<String>((ref) {
  return "";
});

final saveDataProvider = StateProvider<List<ContinuousDataModel>>((ref) {
  return [];
});

final timerProvider = StateProvider<Timer?>((ref) {
  return null;
});

void startTimer(WidgetRef ref) {
  // Retrieve the current timer from the provider
  final currentTimer = ref.read(timerProvider);

  // Cancel the existing timer if it exists
  currentTimer?.cancel();
// Create a new timer and store it in the provider
  ref.read(timerProvider.notifier).state =
      Timer.periodic(const Duration(seconds: 5), (timer) {
    final serialData = ref.read(serialDataProvider);

    // Get the current time in seconds since the timer started
    final secondsElapsed =
        timer.tick * 5; // Since the timer ticks every 5 seconds

    // Insert the time into the test data
    ref.read(serialDataProvider.notifier).addData('Q, +0001, -0002');

    if (serialData.isNotEmpty) {
      final secondVal = getSecondValue(serialData.last);
      final thirdVal = getThirdValue(serialData.last);

      ref.read(secondValueProvider.notifier).state = secondVal;
      ref.read(thirdValueProvider.notifier).state = thirdVal;

      ref
          .read(toBeSavedDataProvider.notifier)
          .addData('$secondsElapsed, $secondVal, $thirdVal');
    }
  });
}

void stopTimer(WidgetRef ref) {
  // Retrieve the current timer from the provider and cancel it
  final currentTimer = ref.read(timerProvider);
  currentTimer?.cancel();
  ref.read(timerProvider.notifier).state = null;
}

String getSecondValue(String data) {
  List<String> parts = data.split(','); // Split the string by commas
  if (parts.length < 2) {
    return "--.-"; // Return default if there are not enough parts
  }
  String secondValue = parts[1].trim();

  if (secondValue.isEmpty) {
    return "--.-";
  } else {
    // Convert the value to an integer to handle leading zeros
    int intValue = int.parse(secondValue);
    // Multiply by -1
    intValue *= -1;
    // Convert the result back to a string and return it
    return intValue.toString();
  }
}

String getThirdValue(String data) {
  List<String> parts = data.split(','); // Split the string by commas
  if (parts.length < 3) {
    return "--.-"; // Return default if there are not enough parts
  }
  String thirdValue = parts[2].trim();

  if (thirdValue.isEmpty) {
    return "--.-";
  } else {
    // Convert the value to an integer to handle leading zeros
    int intValue = int.parse(thirdValue);
    // Convert the result back to a string and return it
    return intValue.toString();
  }
}

class ContinuosReadingData extends ConsumerWidget {
  const ContinuosReadingData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AudioPlayer player = AudioPlayer();
    final stopWatchTimer = ref.watch(stopWatchTimerProvider);
    final serialData = ref.watch(serialDataProvider);
    final secondValue = ref.watch(secondValueProvider);
    final thirdValue = ref.watch(thirdValueProvider);
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
                          serialData.isEmpty ? "--.-" : secondValue,
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
                          serialData.isEmpty ? "--.-" : thirdValue,
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
                  stream: stopWatchTimer.secondTime,
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
                            // ORIGINAL CODE
                            // ref.read(isReadingProvider.notifier).state = false;
                            // stopWatchTimer.onStopTimer();
                            // await stopContinuousData(ref);
                            // if (context.mounted) {
                            //   informationSnackBar(context, Icons.info,
                            //       "Data reading has stopped.");
                            // }

                            // TESTING CODE
                            stopTimer(ref);
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
                          // ORIGINAL CODE
                          // ref.read(isReadingProvider.notifier).state = true;
                          // await player.play(AssetSource('audios/beep-09.wav'),
                          //     volume: 1);
                          // stopWatchTimer.onResetTimer();

                          // await readContinuousData(ref);
                          // startTimer(ref);
                          // if (context.mounted) {
                          //   informationSnackBar(context, Icons.info,
                          //       "Data reading has started.");
                          // }

                          // TESTING CODE
                          stopWatchTimer.onResetTimer();
                          startTimer(ref);
                        },
                ),
                const SizedBox(width: 10),
                RegularButton(
                  buttonText: "Save",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () {
                    if (serialData.isNotEmpty) {
                      stopTimer(ref);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContinuousSaveData(),
                        ),
                      );
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