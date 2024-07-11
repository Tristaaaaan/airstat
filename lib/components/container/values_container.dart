import 'package:airstat/provider/settings_provider.dart';
import 'package:flutter/material.dart';

class ContainerValues extends StatelessWidget {
  final String value;
  final Color? color;
  final SettingsState state;
  final SettingsNotifier notifier;
  const ContainerValues({
    super.key,
    required this.value,
    this.color = Colors.grey,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedValue == value;
    print("isSelected: $isSelected");
    return GestureDetector(
      onTap: () => notifier.selectValue(value),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.greenAccent,
        ),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
