import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// State for log data and received data
final logDataProvider = StateProvider<String>((ref) => "");
final receivedDataProvider = StateProvider<String>((ref) => "");
final selectedPortProvider = StateProvider<String>((ref) => "Selected Port");
final selectedBaudRateProvider =
    StateProvider<int>((ref) => FlutterSerial().baudRateList.first);
final serialListProvider = StateProvider<List<String>>((ref) => []);

final formatProvider = StateProvider<DataFormat>((ref) => DataFormat.ASCII);
final messageProvider = StateProvider<String>((ref) => "");
final serialCommunicationProvider =
    Provider<FlutterSerial>((ref) => FlutterSerial());

class Booth extends HookConsumerWidget {
  const Booth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logData = ref.watch(logDataProvider);
    final receivedData = ref.watch(receivedDataProvider);
    final selectedPort = ref.watch(selectedPortProvider);
    final selectedBaudRate = ref.watch(selectedBaudRateProvider);
    final serialList = ref.watch(serialListProvider);
    final format = ref.watch(formatProvider);

    final serialComm = ref.watch(serialCommunicationProvider);

    useEffect(() {
      final subscription = serialComm.startSerial().listen((result) {
        ref.read(logDataProvider.notifier).state = result.logChannel ?? "";
        ref.read(receivedDataProvider.notifier).state =
            result.readChannel ?? "";
        log('Log Data: $logData');
        log('Received Data: $receivedData');
      });

      getSerialList(ref);

      return subscription.cancel;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serial Communication Checker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (serialList.isEmpty)
              const Center(
                child: Text("No Serial Ports"),
              ),
            if (serialList.isNotEmpty)
              ListView(
                shrinkWrap: true,
                children: serialList
                    .map((port) => ListTile(
                          title: Text(port),
                        ))
                    .toList(),
              )
          ],
        ),
      ),
    );
  }
}

void getSerialList(WidgetRef ref) async {
  final serialComm = ref.watch(serialCommunicationProvider);
  try {
    final ports = await serialComm.getAvailablePorts();
    ref.read(serialListProvider.notifier).state = ports!;
    log('Serial Ports: $ports');
  } catch (e) {
    log('Error fetching serial ports: $e');
  }
}
