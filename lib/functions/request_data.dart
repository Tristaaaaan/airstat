import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:airstat/provider/data_provider.dart';
import 'package:airstat/provider/ports_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usb_serial/usb_serial.dart';

Future<void> stopContinuousData(WidgetRef ref) async {
  ref.read(subscriptionProvider.notifier).state?.cancel();
}

// The function to read continuous data
Future<String> readContinuousData(WidgetRef ref) async {
  try {
    ref.read(isLoadingProvider.notifier).state = true;
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

    subscriptions = port.inputStream!.listen((data) async {
      String receivedMsg = utf8.decode(data);

      ref.read(serialDataProvider.notifier).addData(receivedMsg);
    });

    startTimer(ref);
    ref.read(subscriptionProvider.notifier).state = subscriptions;

    await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
    await Future.delayed(const Duration(milliseconds: 300));
// 'M1',
    // 'U5',
    // 'O1',
    // 'L1',
    // 'P1',
    // 'B3',
    // 'H1',
    // 'NQ',
    // 'F1',
    // 'E3',
    // 'T1',
    // 'S4',
    // 'C2',
    // 'G0',
    // 'K50',
    List<String> commands = [
      'L1',
      'M3',
      'O1',
      'P2',
      'U5',
    ];

    for (String command in commands) {
      await port.write(Uint8List.fromList('\r\n$command\r\n'.codeUnits));
    }

    await port.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
    await Future.delayed(const Duration(seconds: 3));
    await port.write(Uint8List.fromList('Q\r\nQ\r\nQ\r\n'.codeUnits));
    await Future.delayed(const Duration(seconds: 5));

    for (int i = 0; i < 3; i++) {
      await port.write(Uint8List.fromList('Q'.codeUnits));
    }

    ref.read(isLoadingProvider.notifier).state = false;

    return "SUCCESS";
  } catch (e) {
    ref.read(isLoadingProvider.notifier).state = false;
    return Future.error(e);
  }
}
