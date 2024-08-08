import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/settings_container_one.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/models/settings_model.dart';
import 'package:airstat/services/airstat_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> generalSampling = [
  '1',
  '5',
  '10',
  '15',
  '20',
];

const List<String> silhoutteVentsSampling = [
  '1',
  '5',
  '10',
  '15',
  '20',
];

const List<String> generalDelay = [
  '0',
  '5',
  '10',
  '15',
  '20',
];

const List<String> silhoutteVentsDelay = [
  '0',
  '5',
  '10',
  '15',
  '20',
];

const List<String> units = [
  'm/sec',
  'ft/min',
];

final selectedGeneralSamplingProvider = StateProvider<List<bool>>((ref) {
  final currentValue = ref.watch(generalSamplingValueProvider);
  return generalSampling.map((value) => value == currentValue).toList();
});

final silhoutteVentsSamplingProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final selectedGeneralDelayProvider = StateProvider<List<bool>>((ref) {
  final currentValue = ref.watch(generalDelayValueProvider);
  return generalDelay.map((value) => value == currentValue).toList();
});

final silhoutteVentsDelayProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final selectedUnitProvider = StateProvider<List<bool>>((ref) {
  final currentValue = ref.watch(unitValueProvider);
  return units.map((value) => value == currentValue).toList();
});

final generalSamplingValueProvider = StateProvider<String>((ref) {
  return "";
});

final generalDelayValueProvider = StateProvider<String>((ref) {
  return "";
});

final unitValueProvider = StateProvider<String>((ref) {
  return "";
});

class Settings extends ConsumerWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGeneralSampling = ref.watch(selectedGeneralSamplingProvider);
    final selectedSilhoutteVentsSampling =
        ref.watch(silhoutteVentsSamplingProvider);
    final selectedGeneralDelay = ref.watch(selectedGeneralDelayProvider);
    final selectedSilhoutteVentsDelay = ref.watch(silhoutteVentsDelayProvider);
    final selectedUnits = ref.watch(selectedUnitProvider);

    final generalDelayValue = ref.watch(generalDelayValueProvider);
    final generalSamplingValue = ref.watch(generalSamplingValueProvider);
    final unitValue = ref.watch(unitValueProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "General Sampling",
                    style: TextStyle(fontSize: 20),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(selectedGeneralSamplingProvider.notifier).state =
                          List.generate(
                        selectedGeneralSampling.length,
                        (i) => i == index,
                      );

                      ref.read(generalSamplingValueProvider.notifier).state =
                          generalSampling[index];
                      print('General Sampling: ${generalSampling[index]}');
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[200],
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).colorScheme.primary,
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 63,
                    ),
                    isSelected: selectedGeneralSampling,
                    children:
                        generalSampling.map((value) => Text(value)).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Silhouette / Vents Sampling",
                    style: TextStyle(fontSize: 20),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(silhoutteVentsSamplingProvider.notifier).state =
                          List.generate(
                        selectedSilhoutteVentsSampling.length,
                        (i) => i == index,
                      );

                      print(
                          'Silhoutte / Vents Sampling: ${silhoutteVentsSampling[index]}');
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[200],
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).colorScheme.primary,
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 63,
                    ),
                    isSelected: selectedSilhoutteVentsSampling,
                    children: silhoutteVentsSampling
                        .map((value) => Text(value))
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "General Delay",
                    style: TextStyle(fontSize: 20),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(selectedGeneralDelayProvider.notifier).state =
                          List.generate(
                        generalDelay.length,
                        (i) => i == index,
                      );

                      ref.read(generalDelayValueProvider.notifier).state =
                          generalDelay[index];
                      print('General Delay: ${generalDelay[index]}');
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[200],
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).colorScheme.primary,
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 63,
                    ),
                    isSelected: selectedGeneralDelay,
                    children: generalDelay.map((value) => Text(value)).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Silhouette / Vents Delay",
                    style: TextStyle(fontSize: 20),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(silhoutteVentsDelayProvider.notifier).state =
                          List.generate(
                        silhoutteVentsDelay.length,
                        (i) => i == index,
                      );
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[200],
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).colorScheme.primary,
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 63,
                    ),
                    isSelected: selectedSilhoutteVentsDelay,
                    children: silhoutteVentsDelay
                        .map((value) => Text(value))
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Units",
                    style: TextStyle(fontSize: 20),
                  ),
                  ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(selectedUnitProvider.notifier).state =
                          List.generate(
                        units.length,
                        (i) => i == index,
                      );

                      ref.read(unitValueProvider.notifier).state = units[index];
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.red[200],
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).colorScheme.primary,
                    color: Colors.red[400],
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 157.5,
                    ),
                    isSelected: selectedUnits,
                    children: units.map((value) => Text(value)).toList(),
                  ),
                ],
              ),
            ),
            const SettingsContainerOne(category: "Spaces Configuration"),
            const RegularTextField(
                category: "User / Test ID", hinttext: "username"),
            const RegularTextField(
                category: "Cloud Folder", hinttext: "folder name"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.settings,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            RegularButton(
              buttonText: "Save",
              buttonKey: "saveButton",
              width: 100,
              onTap: () async {
                AirstatSettingsModel settings = AirstatSettingsModel(
                  delay: int.parse(generalDelayValue),
                  sampling: int.parse(generalSamplingValue),
                  unit: unitValue,
                );

                AirstatSettingsConfiguration config =
                    AirstatSettingsConfiguration();
                // final dataBefore = await config.getAirstatSettingsDatabase();
                // print("Before Settings: ${dataBefore.toMap()}");
                await config.updateAirstatSettingsDatabase(settings);

                // final dataAfter = await config.getAirstatSettingsDatabase();
                // print("After Settings: ${dataAfter.toMap()}");

                if (context.mounted) {
                  informationSnackBar(
                      context, Icons.check, "Settings has been saved.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
