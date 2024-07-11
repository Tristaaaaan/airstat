// Ask permission status on Android 12 and below
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  if (await Permission.storage.isGranted) {
  } else {
    await Permission.storage.request();
  }
  // Requesting permission for accessing the storage

  var status = await Permission.storage.request();

  if (status.isGranted) {
    // Permission granted, proceed with accessing the storage
  } else if (status.isDenied) {
    // Permission denied
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

// Check permission status on Android 12 and below
Future<bool> checkPermissionStatus() async {
  // Checking permission status for accessing the storage
  var status = await Permission.storage.status;

  return status.isGranted;
}
