import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class BoothPage extends StatefulWidget {
  const BoothPage({super.key});

  @override
  _BoothPage createState() => _BoothPage();
}

class _BoothPage extends State<BoothPage> {
  UsbPort? port;
  bool isLoading = false;
  String status = "Idle";
  final AudioPlayer player = AudioPlayer();
  final List<Uint8List> serialData = [];
  final List<UsbDevice> devices = [];
  final List<String> logs = [];
  String buffer = '';
  StreamSubscription<Uint8List>? subscription;
  Transaction<String>? transaction;
  bool brunConfigurationMode = false;
  Future<bool> connectTo(UsbDevice? device) async {
    serialData.clear();

    try {
      if (subscription != null) {
        logs.add("Cancelling existing subscription.");
        await subscription!.cancel();
        subscription = null;
      }

      if (transaction != null) {
        logs.add("Disposing existing transaction.");
        transaction!.dispose();
        transaction = null;
      }

      if (port != null) {
        logs.add("Closing existing port.");
        await port!.close();
        port = null;
      }

      if (device == null) {
        setState(() {
          status = "Disconnected";
        });
        logs.add("Device is null, disconnected.");
        return true;
      }

      logs.add("Creating port for the device.");
      port = await device.create();
      if (await (port!.open()) != true) {
        setState(() {
          status = "Failed to open port";
        });
        logs.add("Failed to open port");
        return false;
      }

      port!.setDTR(true);
      port!.setRTS(true);

      logs.add("Setting port parameters.");
      await port!.setPortParameters(
        9600, // Check the correct baud rate for WindSonic 75
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      ); // Ensure these match your device's settings
      await port!.setFlowControl(UsbPort.FLOW_CONTROL_OFF);

      logs.add("Port is ready.");

      setState(() {
        status = "Connected";
      });
      logs.add("Connected");
      return true;
    } catch (e) {
      setState(() {
        status = "Error: ${e.toString()}";
      });
      logs.add("Error: ${e.toString()}");
      return false;
    }
  }

  Future<void> readData() async {
    setState(() {
      isLoading = true;
    });
    logs.clear();
    serialData.clear();
    try {
      // TURN ON THE DEVICE
      logs.add("Turning on the device.");
      await port!.write(Uint8List.fromList('**'.codeUnits));
      await Future.delayed(Duration(seconds: 0.3.toInt()));
      await port!.write(Uint8List.fromList('**'.codeUnits));
      subscription = port!.inputStream!.listen((data) {
        onDataReceived(data);
      });

      logs.add("Entering Configuration Mode");
      await port!.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));
      await Future.delayed(Duration(seconds: 0.3.toInt()));
      List<String> commands = [
        'M2',
        'U5',
        'O1',
        'L1',
        'P1',
        'B3',
        'H1',
        'NQ',
        'F1',
        'E3',
        'T1',
        'S4',
        'C2',
        'G0',
        'K50',
      ];

      for (String command in commands) {
        await port!.write(Uint8List.fromList('\r\n$command\r\n'.codeUnits));
      }
      await port!.write(Uint8List.fromList('\r\nD3\r\n'.codeUnits));

      logs.add("Going back to measurement mode.");
      await Future.delayed(const Duration(seconds: 3));
      await port!.write(Uint8List.fromList('Q\r\nQ\r\nQ\r\n'.codeUnits));

      await Future.delayed(const Duration(seconds: 5));

      for (int i = 0; i < 3; i++) {
        await port!.write(Uint8List.fromList('Q'.codeUnits));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      logs.add("Error: ${e.toString()}");
      setState(() {
        isLoading = false;
      });
    }
  }

  void onDataReceived(Uint8List data) {
    String receivedMsg = utf8.decode(data);
    setState(() {
      logs.add(receivedMsg);
    });
    setState(() {
      serialData.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Airstat Test'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Test Information",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Status: $status"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Device: ${port?.toString() ?? 'No Port Connected'}",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Data Received: ${serialData.length}",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (logs.isNotEmpty)
                          IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Divider(),
                                const Text(
                                  "Logs",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${logs.join('\n')}\n",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Step 1. Check the available serial devices",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  onPressed: () async {
                    List<UsbDevice> serialList = await UsbSerial.listDevices();

                    setState(
                      () {
                        devices.clear();
                        devices.addAll(serialList);
                      },
                    );
                  },
                  child: Text(
                    "Check Serial Connection",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (devices.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Text("Step 2. Tap the device to connect"),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            final UsbDevice device = devices[index];
                            return ListTile(
                              leading: const Icon(Icons.usb),
                              title: Text(device.deviceId.toString()),
                              subtitle: Text(device.manufacturerName ?? ''),
                              onTap: () async {
                                bool result = await connectTo(device);

                                if (result) {
                                  if (context.mounted) {
                                    informationSnackBar(context, Icons.usb,
                                        "Connected to device ${device.deviceId}");
                                  } else {
                                    if (context.mounted) {
                                      informationSnackBar(context, Icons.usb,
                                          "Failed to connect to the ${device.deviceId}");
                                    }
                                  }
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                if (port != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Text(
                        "Step 3. Request to read data from the device",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                logs.add("Requested to read data.");
                                await player.play(
                                    AssetSource('audios/beep-09.wav'),
                                    volume: 1);
                                await readData();

                                if (context.mounted) {
                                  informationSnackBar(context, Icons.usb,
                                      "Requesting to read data");
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Read Data",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                if (serialData.isNotEmpty)
                  SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          const Text(
                            "Data",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text("Serial Data: $serialData"),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
