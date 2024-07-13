// Ask permission status on Android 12 and below
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  var status = await Permission.systemAlertWindow.status;
  if (!status.isGranted) {
    await Permission.systemAlertWindow.request();
  }
}

Future<bool> checkPermission() {
  return Permission.systemAlertWindow.isGranted;
}
