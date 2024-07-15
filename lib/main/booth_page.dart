import 'dart:async';
import 'dart:typed_data';

import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class BoothPage extends StatefulWidget {
  const BoothPage({super.key});

  @override
  _BoothPage createState() => _BoothPage();
}

class _BoothPage extends State<BoothPage> {
  UsbPort? _port;
  String _status = "Idle";

  final List<String> _serialData = [];
  final List<UsbDevice> _devices = [];
  final List<String> _logs = [];
  StreamSubscription<Uint8List>? _subscription;
  Transaction<String>? _transaction;

  Future<bool> _connectTo(UsbDevice? device) async {
    _serialData.clear();

    try {
      if (_subscription != null) {
        _logs.add("Cancelling existing subscription.");
        await _subscription!.cancel();
        _subscription = null;
      }

      if (_transaction != null) {
        _logs.add("Disposing existing transaction.");
        _transaction!.dispose();
        _transaction = null;
      }

      if (_port != null) {
        _logs.add("Closing existing port.");
        await _port!.close();
        _port = null;
      }

      if (device == null) {
        setState(() {
          _status = "Disconnected";
        });
        _logs.add("Device is null, disconnected.");
        return true;
      }

      _logs.add("Creating port for the device.");
      _port = await device.create();
      if (await (_port!.open()) != true) {
        setState(() {
          _status = "Failed to open port";
        });
        _logs.add("Failed to open port");
        return false;
      }

      _logs.add("Setting DTR and RTS.");
      await _port!.setDTR(true);
      await _port!.setRTS(true);
      _logs.add("Setting port parameters.");
      await _port!.setPortParameters(
          9600, // Check the correct baud rate for WindSonic 75
          UsbPort.DATABITS_8,
          UsbPort.STOPBITS_1,
          UsbPort.PARITY_NONE); // Ensure these match your device's settings

      // Set flow control to DSR/DTR
      _logs.add("Setting flow control to DSR/DTR.");
      await _port!.setFlowControl(UsbPort.FLOW_CONTROL_DSR_DTR);

      _logs.add("Listening to input stream.");
      _subscription = _port!.inputStream!.listen((Uint8List data) {
        setState(() {
          _serialData.add("Received raw data: ${data.toString()}");
          // String receivedData = String.fromCharCodes(data);
          // _serialData.add(receivedData);
          // if (_serialData.length > 20) {
          //   _serialData.removeAt(0);
          // }
        });
      });

      setState(() {
        _status = "Connected";
      });
      _logs.add("Connected");
      return true;
    } catch (e) {
      setState(() {
        _status = "Error: ${e.toString()}";
      });
      _logs.add("Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('USB Serial Plugin example app'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    List<UsbDevice> serialList = await UsbSerial.listDevices();

                    setState(() {
                      _devices.clear();
                      _devices.addAll(serialList);
                    });
                  },
                  child: const Text(
                    "Check Serial Connection",
                  ),
                ),
                if (_logs.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_logs[index]),
                        );
                      },
                    ),
                  ),
                if (_devices.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        final UsbDevice device = _devices[index];
                        return ListTile(
                          leading: const Icon(Icons.usb),
                          title: Text(device.deviceId.toString()),
                          subtitle: Text(device.manufacturerName ?? ''),
                          onTap: () async {
                            await _connectTo(device);
                            if (context.mounted) {
                              informationSnackBar(
                                  context, Icons.usb, "Connecting...");
                            }
                          },
                        );
                      },
                    ),
                  ),
                Text('Status: $_status\n'),
                Text('info: ${_port.toString()}\n'),
                if (_serialData.isNotEmpty)
                  Text("RESULT: ${_serialData.join('\n')}\n"),
                Text("RESULT: ${_serialData.join('\n')}\n",
                    style: Theme.of(context).textTheme.titleLarge),
                if (_logs.isNotEmpty) Text("RESULT: ${_logs.join('\n')}\n"),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
