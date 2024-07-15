import 'dart:async';
import 'dart:typed_data';

import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/permission/permission_handlers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

final serialDevicesProvider = StateProvider<List<UsbDevice>>((ref) => []);

final transactionProvider = StateProvider<Transaction<String>?>((_) => null);
StreamSubscription<String>? subscription;
Transaction<String>? transaction;

class Continuous extends ConsumerWidget {
  const Continuous({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serialDevices = ref.watch(serialDevicesProvider);
    final serialString = ref.watch(stringContainerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Serial Devices"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  var status = await checkPermission();

                  if (!status) {
                    await requestPermissions();
                  } else {
                    List<UsbDevice> serialList = await UsbSerial.listDevices();
                    if (serialList.isEmpty) {
                      if (context.mounted) {
                        informationSnackBar(context, Icons.error,
                            "There are no available ports");
                      }
                    } else {
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.check, "Available ports found");
                      }

                      ref.read(serialDevicesProvider.notifier).state =
                          serialList;
                    }
                  }
                },
                child: const Text("SEARCH SERIAL DEVICES"),
              ),
              if (serialDevices.isEmpty) const Text("No Serial Devices Found"),
              if (serialString.isEmpty) const Text("No serialString Found"),
              if (serialString.isNotEmpty)
                Text("serialString Found: $serialString"),
              if (serialDevices.isNotEmpty)
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: serialDevices.length,
                    itemBuilder: (context, index) {
                      final UsbDevice device = serialDevices[index];
                      return ListTile(
                        leading: const Icon(Icons.usb),
                        title: Text(device.deviceId.toString()),
                        subtitle: Text(device.manufacturerName ?? ''),
                        onTap: () async {
                          // Handle device connection here
                          await connectToDevice(device, ref);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> connectToDevice(UsbDevice device, WidgetRef ref) async {
  UsbPort? port = await device.create();
  if (await port?.open() != true) {
    return false;
  }

  await port?.setDTR(true);
  await port?.setRTS(true);
  await port?.setPortParameters(
      115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

  Transaction<String> transaction = Transaction.stringTerminated(
      port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

  ref.read(transactionProvider.notifier).state = transaction;

  subscription = transaction.stream.listen((String line) {
    final states = ref.read(stringContainerProvider.notifier);
    states.state = [...states.state, line];

    // Limit list size to 20 elements
    if (states.state.length > 20) {
      states.state = states.state.sublist(states.state.length - 20);
    }
  });

  return true;
}

final stringContainerProvider = StateProvider<List<String>>((_) => []);
