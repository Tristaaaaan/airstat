import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/main/random/random_reading_page.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:airstat/provider/ports_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usb_serial/usb_serial.dart';

Future<void> stopContinuousData(WidgetRef ref) async {
  ref.read(subscriptionProvider.notifier).state?.cancel();
}

// The function to read continuous data
Future<String> readContinuousData(WidgetRef ref, String unit) async {
  final isReading = ref.watch(isLoadingProvider).containsKey("continuousRead")
      ? ref.watch(isLoadingProvider)["continuousRead"]
      : false;
  // print("Is Reading: $isReading");
  // await Future.delayed(const Duration(seconds: 5));
  // return "SUCCESS";

  // REMOVE THE COMMENTS AFTER TESTING
  try {
    String? unitValue;

    if (unit == "f/min") {
      unitValue = "U5";
    } else {
      unitValue = "U1";
    }

    List<UsbDevice> serialList = await UsbSerial.listDevices();
    UsbPort? port = await serialList.first.create();
    if (await (port!.open()) != true) {
      return "FAILED";
    }

    port.setDTR(true);
    port.setRTS(true);

    await port.setPortParameters(
      9600, // Check the correct baud rate for WindSonic 75
      UsbPort.DATABITS_8,
      UsbPort.STOPBITS_1,
      UsbPort.PARITY_NONE,
    ); // Ensure these match your device's settings
    await port.setFlowControl(UsbPort.FLOW_CONTROL_OFF);

    ref.read(serialDataProvider.notifier).clearData();
    var subscriptions = ref.watch(subscriptionProvider);

    await port.write(Uint8List.fromList('**'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));
    await port.write(Uint8List.fromList('**'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    subscriptions = port.inputStream!.listen((data) async {
      String receivedMsg = utf8.decode(data);

      ref.read(serialDataProvider.notifier).addData(receivedMsg);
    });

    ref.read(subscriptionProvider.notifier).state = subscriptions;

    List<String> commands = [
      'M3',
      'L1',
      'O1',
      'P2',
      unitValue,
    ];

    await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    for (String command in commands) {
      await port.write(Uint8List.fromList('\r\n$command\r\n'.codeUnits));
    }

    await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    await port.write(Uint8List.fromList('\r\nQ\r\n'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    await port.write(Uint8List.fromList('?'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    await port.write(Uint8List.fromList('&'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));

    await port.write(Uint8List.fromList('Q'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));
    // await port.write(Uint8List.fromList('Q'.codeUnits));
    // await Future.delayed(const Duration(milliseconds: 300));
    startTimer(ref);
    while (isReading!) {
      await Future.delayed(
        const Duration(seconds: 3),
        () async {
          await port.write(Uint8List.fromList('Q'.codeUnits));
        },
      );
    }

    return "SUCCESS";
  } catch (e) {
    return Future.error(e);
  }
}

// The function to read continuous data
Future<String> readRandomData(
  WidgetRef ref,
  String unit,
) async {
  // try {
  //   var subscriptions = ref.watch(subscriptionProvider);
  //   String? unitValue;

  //   if (unit == "f/min") {
  //     unitValue = "U5";
  //   } else {
  //     unitValue = "U1";
  //   }
  //   List<UsbDevice> serialList = await UsbSerial.listDevices();
  //   UsbPort? port = await serialList.first.create();
  //   if (await (port!.open()) != true) {
  //     return "FAILED";
  //   }

  //   port.setDTR(true);
  //   port.setRTS(true);

  //   await port.setPortParameters(
  //     9600, // Check the correct baud rate for WindSonic 75
  //     UsbPort.DATABITS_8,
  //     UsbPort.STOPBITS_1,
  //     UsbPort.PARITY_NONE,
  //   ); // Ensure these match your device's settings
  //   await port.setFlowControl(UsbPort.FLOW_CONTROL_OFF);

  //   ref.read(serialDataProvider.notifier).clearData();
  //   await port.write(Uint8List.fromList('**'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   await port.write(Uint8List.fromList('**'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   subscriptions = port.inputStream!.listen((data) async {
  //     String receivedMsg = utf8.decode(data);

  //     ref.read(serialDataProvider.notifier).addData(receivedMsg);
  //   });

  //   ref.read(subscriptionProvider.notifier).state = subscriptions;

  //   List<String> commands = [
  //     'M3',
  //     'L1',
  //     'O1',
  //     'P2',
  //     unitValue,
  //   ];

  //   await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   for (String command in commands) {
  //     await port.write(Uint8List.fromList('\r\n$command\r\n'.codeUnits));
  //   }

  //   await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('\r\nQ\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('?'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('&'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('Q'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('Q'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   getRandomData(ref);

  //   return "SUCCESS";
  // } catch (e) {
  //   return Future.error(e);
  // } finally {
  //   ref.read(subscriptionProvider.notifier).state?.cancel();
  // }

  getRandomData(ref);

  return "SUCCESS";
}

final dataCountProvider = StateProvider<int>((ref) => 0);

void getRandomData(WidgetRef ref) {
  // ORIGINAL
  // final serialData = ref.watch(serialDataProvider).last;

  // // Insert the time into the test data
  // ref.read(serialDataProvider.notifier).addData(serialData);

  // List<String> parts = serialData.split(','); // Split the string by commas

  // if (parts.length >= 2) {
  //   final secondVal = getSecondValue(serialData);
  //   final thirdVal = getThirdValue(serialData);

  //   ref.read(secondValueProvider.notifier).state = secondVal;
  //   ref.read(thirdValueProvider.notifier).state = thirdVal;

  //   // Get the current count and increment it
  //   final currentCount = ref.read(dataCountProvider);
  //   ref.read(dataCountProvider.notifier).state = currentCount + 1;

  //   ref
  //       .read(toBeSavedDataProvider.notifier)
  //       .addData('$currentCount, $secondVal, $thirdVal');

  //   String data = '[$secondVal, $thirdVal]';
  //   ref.read(randomReadingDataHolder.notifier).addData(data);
  // }

  // TEST
  // Get the current count and increment it
  final currentCount = ref.read(dataCountProvider);
  ref.read(dataCountProvider.notifier).state = currentCount + 1;

  final random = Random();
  final firstValue = (random.nextInt(100) + 1).toString();
  final secondValue = (random.nextInt(100) + 1).toString();
  ref
      .read(toBeSavedDataProvider.notifier)
      .addData('$currentCount, $firstValue, $secondValue');

  String data = '[$secondValue, $secondValue]';
  ref.read(randomReadingDataHolder.notifier).addData(data);
}

Future<List<String>> getBoothData(WidgetRef ref) async {
  final serialData = ref.watch(serialDataProvider).last;

  // Insert the time into the test data
  ref.read(serialDataProvider.notifier).addData(serialData);

  List<String> parts = serialData.split(','); // Split the string by commas

  if (parts.length >= 2) {
    final secondVal = getSecondValue(serialData);
    final thirdVal = getThirdValue(serialData);

    ref.read(secondValueProvider.notifier).state = secondVal;
    ref.read(thirdValueProvider.notifier).state = thirdVal;

    return [secondVal, thirdVal];
  } else {
    return ['--.-', '--.-'];
  }
}

Future<List<String>> readBoothData(
  WidgetRef ref,
  String unit,
) async {
  // ORIGINAL
  // try {
  //   var subscriptions = ref.watch(subscriptionProvider);
  //   String? unitValue;

  //   if (unit == "f/min") {
  //     unitValue = "U5";
  //   } else {
  //     unitValue = "U1";
  //   }
  //   List<UsbDevice> serialList = await UsbSerial.listDevices();
  //   UsbPort? port = await serialList.first.create();
  //   if (await (port!.open()) != true) {
  //     return ['--.-', '--.-'];
  //   }

  //   port.setDTR(true);
  //   port.setRTS(true);

  //   await port.setPortParameters(
  //     9600, // Check the correct baud rate for WindSonic 75
  //     UsbPort.DATABITS_8,
  //     UsbPort.STOPBITS_1,
  //     UsbPort.PARITY_NONE,
  //   ); // Ensure these match your device's settings
  //   await port.setFlowControl(UsbPort.FLOW_CONTROL_OFF);

  //   ref.read(serialDataProvider.notifier).clearData();
  //   await port.write(Uint8List.fromList('**'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   await port.write(Uint8List.fromList('**'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   subscriptions = port.inputStream!.listen((data) async {
  //     String receivedMsg = utf8.decode(data);

  //     ref.read(serialDataProvider.notifier).addData(receivedMsg);
  //   });

  //   ref.read(subscriptionProvider.notifier).state = subscriptions;

  //   List<String> commands = [
  //     'M3',
  //     'L1',
  //     'O1',
  //     'P2',
  //     unitValue,
  //   ];

  //   await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   for (String command in commands) {
  //     await port.write(Uint8List.fromList('\r\n$command\r\n'.codeUnits));
  //   }

  //   await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('\r\nQ\r\n'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('?'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('&'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   await port.write(Uint8List.fromList('Q'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   // await port.write(Uint8List.fromList('Q'.codeUnits));
  //   // await Future.delayed(const Duration(milliseconds: 300));
  //   await port.write(Uint8List.fromList('Q'.codeUnits));
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   final data = getBoothData(ref);

  //   return data;
  // } catch (e) {
  //   return Future.error(e);
  // } finally {
  //   ref.read(subscriptionProvider.notifier).state?.cancel();
  // }

  final random = Random();
  final firstValue = (random.nextInt(100) + 1).toString();
  final secondValue = (random.nextInt(100) + 1).toString();
  return Future.value([firstValue, secondValue]);
}
