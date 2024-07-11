import 'package:hooks_riverpod/hooks_riverpod.dart';

// State for the available serial ports
final serialListProvider = StateProvider<List<String>>((ref) => []);

// State for log data and received data
final logDataProvider = StateProvider<String>((ref) => "");
final receivedDataProvider = StateProvider<String>((ref) => "");
