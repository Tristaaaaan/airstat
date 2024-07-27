import 'package:airstat/main/homepage.dart';
import 'package:airstat/services/airstat_database.dart';
import 'package:airstat/themes/lightmode/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AirstatSettingsConfiguration().initializeDatabase();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      theme: lightMode,
      home: const Home(),
    );
  }
}
