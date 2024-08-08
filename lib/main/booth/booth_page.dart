import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/main/booth/dynamictables/entrance_silhoutte_dynamic_table.dart';
import 'package:airstat/main/booth/entrance_silhouette_page.dart';
import 'package:airstat/models/space_definition_model.dart';
import 'package:airstat/services/space_definitions_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final siteValueProvider = StateProvider<String>((ref) {
  return "";
});

final shopValueProvider = StateProvider<String>((ref) {
  return "";
});

final lineValueProvider = StateProvider<String>((ref) {
  return "";
});

final zoneValueProvider = StateProvider<String>((ref) {
  return "";
});

final boothRowsProvider = StateProvider<int>((ref) {
  return 0;
});

final boothColumnsProvider = StateProvider<int>((ref) {
  return 0;
});

final boothSilhouetteWidthProvider = StateProvider<int>((ref) {
  return 0;
});

final boothSilhouetteHeightProvider = StateProvider<int>((ref) {
  return 0;
});

final boothTargetDdProvider = StateProvider<String>((ref) {
  return "";
});

final boothTargetCdProvider = StateProvider<String>((ref) {
  return "";
});

final boothDdDeltaProvider = StateProvider<String>((ref) {
  return "";
});

final boothCdDeltaProvider = StateProvider<String>((ref) {
  return "";
});

class BoothPage extends HookConsumerWidget {
  const BoothPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteValue = ref.watch(siteValueProvider);
    final shopValue = ref.watch(shopValueProvider);
    final lineValue = ref.watch(lineValueProvider);
    final zoneValue = ref.watch(zoneValueProvider);

    final siteLabels = useState<List<String>>([]);
    final shopLabels = useState<List<String>>([]);
    final lineLabels = useState<List<String>>([]);
    final zoneLabels = useState<List<String>>([]);

    void initializeSettings() async {
      final List<Configuration> data =
          await SpaceDefinitionsDatabase().getAllConfigurations();

      // Extract the id1 values from the data and use a Set to filter out duplicates
      final uniqueSiteLabels =
          data.map((config) => config.id1).toSet().toList();

      siteLabels.value = uniqueSiteLabels;
    }

    Future<void> getShopLabels() async {
      print("Current Site Value: ${ref.watch(siteValueProvider)}");
      // Fetch configurations from the database
      final List<Configuration> data =
          await SpaceDefinitionsDatabase().getAllConfigurations();

      // Get the current value from siteValueProvider
      final currentSiteValue = ref.watch(siteValueProvider);

      // Filter `id2` where `id1` equals `currentSiteValue`
      final uniqueShopLabels = data
          .where(
              (config) => config.id1 == currentSiteValue) // Filter based on id1
          .map((config) => config.id2) // Extract id2 values
          .toSet() // Remove duplicates
          .toList(); // Convert to list
      print("Unique Shop Labels: $uniqueShopLabels");
      // Update the state with the uniqueSiteLabels
      shopLabels.value = uniqueShopLabels;
    }

    Future<void> getLineLabels() async {
      // Fetch configurations from the database
      final List<Configuration> data =
          await SpaceDefinitionsDatabase().getAllConfigurations();
      final currentSiteValue = ref.watch(siteValueProvider);

      final currentShopValue = ref.watch(shopValueProvider);
      // Filter `id3`
      final uniqueLineLabels = data
          .where((config) =>
              config.id1 == currentSiteValue &&
              config.id2 == currentShopValue) // Filter based on id1
          .map((config) => config.id3) // Extract id2 values
          .toSet() // Remove duplicates
          .toList(); // Convert to list
      print("Unique Shop Labels: $uniqueLineLabels");
      // Update the state with the uniqueSiteLabels
      lineLabels.value = uniqueLineLabels;
    }

    Future<void> getZoneLabels() async {
      // Fetch configurations from the database
      final List<Configuration> data =
          await SpaceDefinitionsDatabase().getAllConfigurations();
      final currentSiteValue = ref.watch(siteValueProvider);

      final currentShopValue = ref.watch(shopValueProvider);
      final currentLineValue = ref.watch(lineValueProvider);
      // Filter `id3`
      final uniqueZoneLabels = data
          .where((config) =>
              config.id1 == currentSiteValue &&
              config.id2 == currentShopValue &&
              config.id3 == currentLineValue) // Filter based on id1
          .map((config) => config.id4) // Extract id2 values
          .toSet() // Remove duplicates
          .toList(); // Convert to list

      print("Unique Shop Labels: $uniqueZoneLabels");
      // Update the state with the uniqueSiteLabels
      zoneLabels.value = uniqueZoneLabels;
    }

    Future<bool> getRowData() async {
      final List<Configuration> data =
          await SpaceDefinitionsDatabase().getAllConfigurations();
      final currentSiteValue = ref.watch(siteValueProvider);

      final currentShopValue = ref.watch(shopValueProvider);
      final currentLineValue = ref.watch(lineValueProvider);
      final currentZoneValue = ref.watch(zoneValueProvider);
      // Filter `id3`
      final uniqueZoneLabels = data
              .where((config) =>
                  config.id1 == currentSiteValue &&
                  config.id2 == currentShopValue &&
                  config.id3 == currentLineValue &&
                  config.id4 == currentZoneValue) // Filter based on id1
              .map((config) => config) // Extract id2 values
          // Remove duplicates
          ; // Convert to list
      print(
          "Unique Shop Labels: ${uniqueZoneLabels.map((e) => e.silHeight).join(', ')}");
      if (uniqueZoneLabels.isEmpty) {
        return false;
      } else {
        ref.read(boothRowsProvider.notifier).state =
            int.parse(uniqueZoneLabels.map((e) => e.xRows).join(', '));
        ref.read(boothColumnsProvider.notifier).state =
            int.parse(uniqueZoneLabels.map((e) => e.yReadPerRow).join(', '));
        ref.read(boothSilhouetteWidthProvider.notifier).state =
            int.parse(uniqueZoneLabels.map((e) => e.zSilWidth).join(', '));
        ref.read(boothSilhouetteHeightProvider.notifier).state =
            int.parse(uniqueZoneLabels.map((e) => e.silHeight).join(', '));

        ref.read(boothTargetDdProvider.notifier).state =
            uniqueZoneLabels.map((e) => e.targetDd).join(', ');

        ref.read(boothTargetCdProvider.notifier).state =
            uniqueZoneLabels.map((e) => e.targetSide).join(', ');

        ref.read(boothDdDeltaProvider.notifier).state =
            uniqueZoneLabels.map((e) => e.varDd).join(', ');
        ref.read(boothCdDeltaProvider.notifier).state =
            uniqueZoneLabels.map((e) => e.varCd).join(', ');
        return true;
      }
    }

    useEffect(() {
      initializeSettings();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booth"),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Site",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<String>(
                            dropdownMenuEntries: siteLabels.value
                                .map<DropdownMenuEntry<String>>(
                                    (String content) {
                              return DropdownMenuEntry<String>(
                                value: content,
                                label: content,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) async {
                              print("value: $value");

                              ref.read(siteValueProvider.notifier).state =
                                  value!;
                              await getShopLabels();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (siteValue.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shop",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 315,
                            child: DropdownMenu<String>(
                              dropdownMenuEntries: shopLabels.value
                                  .map<DropdownMenuEntry<String>>(
                                      (String content) {
                                return DropdownMenuEntry<String>(
                                  value: content,
                                  label: content,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                );
                              }).toList(),
                              expandedInsets: const EdgeInsets.all(0),
                              onSelected: (value) async {
                                // Update the state with the selected value
                                ref.read(shopValueProvider.notifier).state =
                                    value!;

                                // Delay to ensure state update propagation (if necessary)

                                // Fetch and update zone labels or any other dependent data
                                await getLineLabels();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (siteValue.isNotEmpty && shopValue.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Line",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 315,
                            child: DropdownMenu<String>(
                              dropdownMenuEntries: lineLabels.value
                                  .map<DropdownMenuEntry<String>>(
                                      (String content) {
                                return DropdownMenuEntry<String>(
                                  value: content,
                                  label: content,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                );
                              }).toList(),
                              expandedInsets: const EdgeInsets.all(0),
                              onSelected: (value) async {
                                // Update the state with the selected value
                                ref.read(lineValueProvider.notifier).state =
                                    value!;

                                // Fetch and update zone labels or any other dependent data
                                await getZoneLabels();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (siteValue.isNotEmpty &&
                shopValue.isNotEmpty &&
                lineValue.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Zone",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 315,
                            child: DropdownMenu<String>(
                              dropdownMenuEntries: zoneLabels.value
                                  .map<DropdownMenuEntry<String>>(
                                      (String content) {
                                return DropdownMenuEntry<String>(
                                  value: content,
                                  label: content,
                                  style: MenuItemButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                );
                              }).toList(),
                              expandedInsets: const EdgeInsets.all(0),
                              onSelected: (value) async {
                                // Update the state with the selected value
                                ref.read(zoneValueProvider.notifier).state =
                                    value!;

                                // Delay to ensure state update propagation (if necessary)

                                // Fetch and update zone labels or any other dependent data
                                // await getZoneLabels();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
            Image.asset(
              "assets/icons/Special_DD.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
              buttonText: "Next",
              buttonKey: "boothNext",
              width: 100,
              onTap: () async {
                if (ref.watch(siteValueProvider) == "" ||
                    ref.watch(shopValueProvider) == "" ||
                    ref.watch(lineValueProvider) == "" ||
                    ref.watch(zoneValueProvider) == "") {
                  informationSnackBar(
                      context, Icons.warning, "Please fill in all the fields");
                } else {
                  final bool rowData = await getRowData();

                  if (rowData) {
                    ref.read(selectedBoxProvider.notifier).clearValues();
                    print(
                        "There is no mismatch in the space definition you entered");

                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const EntranceSilhouette();
                          },
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      informationSnackBar(context, Icons.warning,
                          "There is a mismatch in the space definition you entered");
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
