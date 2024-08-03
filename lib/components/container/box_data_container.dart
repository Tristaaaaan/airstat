import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provider for the SelectedBoxNotifier
final selectedBoothReadingBoxProvider =
    StateNotifierProvider<SelectedBoothReadingBoxNotifier, Map<String, int?>>(
        (ref) {
  return SelectedBoothReadingBoxNotifier();
});

// StateNotifier to manage selected box
class SelectedBoothReadingBoxNotifier extends StateNotifier<Map<String, int?>> {
  SelectedBoothReadingBoxNotifier() : super({'row': null, 'col': null});

  void selectBox(int row, int col) {
    state = {'row': row, 'col': col};
  }

  void updateSelectedBoxValue() {
    final random = Random();
    final newValue = (random.nextInt(100) + 1); // Generate a new random value
    state = {'row': state['row'], 'col': state['col'], 'value': newValue};
  }
}

// Provider for the SelectedBoxNotifier
final selectedExitSilhouetteBoxProvider =
    StateNotifierProvider<SelectedExitSilhouetteBoxNotifier, Map<String, int?>>(
        (ref) {
  return SelectedExitSilhouetteBoxNotifier();
});

// StateNotifier to manage selected box
class SelectedExitSilhouetteBoxNotifier
    extends StateNotifier<Map<String, int?>> {
  SelectedExitSilhouetteBoxNotifier() : super({'row': null, 'col': null});

  void selectBox(int row, int col) {
    state = {'row': row, 'col': col};
  }
}

class BoxDataContainer extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const BoxDataContainer({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            value == "" ? "--.-" : value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
