import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/settings_container_one.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/models/settings_model.dart';
import 'package:airstat/services/airstat_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<Widget> generalSampling = <Widget>[
  Text('1'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5')
];

const List<Widget> silhoutteVentsSampling = <Widget>[
  Text('1'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5')
];

const List<Widget> generalDelay = <Widget>[
  Text('0'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5')
];

const List<Widget> silhoutteVentsDelay = <Widget>[
  Text('0'),
  Text('2'),
  Text('3'),
  Text('4'),
  Text('5')
];

const List<Widget> units = <Widget>[
  Text('m/sec'),
  Text('fit/min'),
];

final generalSamplingProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final silhoutteVentsSamplingProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final generalDelayProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final silhoutteVentsDelayProvider = StateProvider<List<bool>>((ref) {
  return [true, false, false, false, false];
});

final unitsProvider = StateProvider<List<bool>>((ref) {
  return [true, false];
});

class Settings extends ConsumerWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGeneralSampling = ref.watch(generalSamplingProvider);
    final selectedSilhoutteVentsSampling =
        ref.watch(silhoutteVentsSamplingProvider);
    final selectedGeneralDelay = ref.watch(generalDelayProvider);
    final selectedSilhoutteVentsDelay = ref.watch(silhoutteVentsDelayProvider);
    final selectedUnits = ref.watch(unitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Sampling: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Text(
                    "Delay: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Text(
                    "Units: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
            ],
          )
        ],
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
                      ref.read(generalSamplingProvider.notifier).state =
                          List.generate(
                        selectedGeneralSampling.length,
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
                    isSelected: selectedGeneralSampling,
                    children: generalSampling,
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
                    children: silhoutteVentsSampling,
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
                      ref.read(generalDelayProvider.notifier).state =
                          List.generate(
                        generalDelay.length,
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
                    isSelected: selectedGeneralDelay,
                    children: generalDelay,
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
                    children: silhoutteVentsDelay,
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
                      ref.read(unitsProvider.notifier).state = List.generate(
                        units.length,
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
                      minWidth: 157.5,
                    ),
                    isSelected: selectedUnits,
                    children: units,
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
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () async {
                AirstatSettingsModel settings = AirstatSettingsModel(
                  delay: 1,
                  sampling: 20,
                  unit: "ft/min",
                );

                AirstatSettingsConfiguration config =
                    AirstatSettingsConfiguration();
                final dataBefore = await config.getAirstatSettingsDatabase();
                print("Before Settings: $dataBefore");
                await config.updateAirstatSettingsDatabase(settings);

                final dataAfter = await config.getAirstatSettingsDatabase();
                print("After Settings: $dataAfter");
              },
            ),
          ],
        ),
      ),
    );
  }
}
