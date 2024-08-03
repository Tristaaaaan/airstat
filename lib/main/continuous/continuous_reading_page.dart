import 'dart:async';

import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/continuous/continuous_save_data.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// Controls the StopWatchTimer package for each sensor
final stopWatchTimerProvider = StateProvider<StopWatchTimer>((ref) {
  return StopWatchTimer();
});

final secondValueProvider = StateProvider<String>((ref) {
  return "";
});

final thirdValueProvider = StateProvider<String>((ref) {
  return "";
});

final timerProvider = StateProvider<Timer?>((ref) {
  return null;
});

void startTimer(
  WidgetRef ref,
) {
  final currentTimer = ref.read(timerProvider);

  // Cancel the existing timer if it exists
  currentTimer?.cancel();

// Create a new timer and store it in the provider
  ref.read(timerProvider.notifier).state = Timer.periodic(
    const Duration(seconds: 3),
    (timer) {
      final serialData = ref.watch(serialDataProvider).last;

      // Get the current time in seconds since the timer started
      final secondsElapsed =
          timer.tick * 3; // Since the timer ticks every 5 seconds

      // Insert the time into the test data
      ref.read(serialDataProvider.notifier).addData(serialData);

      if (serialData.isNotEmpty) {
        final secondVal = getSecondValue(serialData);
        final thirdVal = getThirdValue(serialData);

        ref.read(secondValueProvider.notifier).state = secondVal;
        ref.read(thirdValueProvider.notifier).state = thirdVal;

        ref
            .read(toBeSavedDataProvider.notifier)
            .addData('$secondsElapsed, $secondVal, $thirdVal');
      }
    },
  );
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
  final String zoneId;
  const ContinuosReadingData({
    super.key,
    required this.zoneId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AudioPlayer player = AudioPlayer();
    final stopWatchTimer = ref.watch(stopWatchTimerProvider);
    final serialData = ref.watch(serialDataProvider);
    final secondValue = ref.watch(secondValueProvider);
    final thirdValue = ref.watch(thirdValueProvider);

    final toBeSaved = ref.watch(toBeSavedDataProvider);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Continuous"),
          actions: const [AirstatSettingsAppBar()],
        ),
        body: Column(
          children: [
            IntrinsicHeight(
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
                          style: const TextStyle(fontSize: 100),
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
                          style: const TextStyle(fontSize: 100),
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
                      buttonKey: "continuousStop",
                      buttonText: "Stop",
                      width: 100,
                      onTap: () async {
                        // ORIGINAL CODE
                        ref
                            .read(isLoadingProvider.notifier)
                            .setLoading("continuousRead", false);
                        stopWatchTimer.onStopTimer();
                        stopTimer(ref);
                        await stopContinuousData(ref);

                        if (context.mounted) {
                          informationSnackBar(
                              context, Icons.info, "Data reading has stopped.");
                        }
                      }),
                  const SizedBox(width: 10),
                  RegularButton(
                    buttonKey: "continuousRead",
                    buttonText: "Read",
                    width: 100,
                    onTap: () async {
                      // ORIGINAL CODE
                      ref
                          .read(isLoadingProvider.notifier)
                          .setLoading("continuousRead", true);
                      await player.play(AssetSource('audios/beep-09.wav'),
                          volume: 1);
                      stopWatchTimer.onResetTimer();
                      stopWatchTimer.onStartTimer();
                      await readContinuousData(
                        ref,
                        ref.watch(unitValueProvider),
                      );

                      if (context.mounted) {
                        informationSnackBar(context, Icons.info,
                            "Data reading has been initialized.");
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  RegularButton(
                    buttonText: "Save",
                    buttonKey: "continuousSave",
                    width: 100,
                    onTap: toBeSaved.isEmpty
                        ? () {
                            if (context.mounted) {
                              informationSnackBar(context, Icons.info,
                                  "There is no data to save.");
                            }
                          }
                        : () {
                            if (serialData.isNotEmpty) {
                              stopTimer(ref);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContinuousSaveData(
                                    zoneId: zoneId,
                                  ),
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
      ),
    );
  }
}
