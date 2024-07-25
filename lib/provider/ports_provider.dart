import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:usb_serial/usb_serial.dart';

final usbDevicesProvider = StateProvider<List<UsbDevice?>>((ref) {
  return [];
});

final usbPortProvider = StateProvider<UsbPort?>((ref) {
  return null;
});

final subscriptionProvider =
    StateProvider<StreamSubscription<Uint8List>?>((ref) {
  return null;
});
