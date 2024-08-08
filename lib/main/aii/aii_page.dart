import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/main/aii/anteroom.dart';
import 'package:airstat/main/booth/booth_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AirborneInfectionIsolationPage extends ConsumerWidget {
  const AirborneInfectionIsolationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siteValue = ref.watch(siteValueProvider);
    final shopValue = ref.watch(shopValueProvider);
    final lineValue = ref.watch(lineValueProvider);
    final zoneValue = ref.watch(zoneValueProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("A.I.I."),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Site",
                          style: TextStyle(fontSize: 20),
                        ),
                        // SizedBox(
                        //   width: 315,
                        //   child: DropdownMenu<SiteLabels>(
                        //     dropdownMenuEntries: SiteLabels.values
                        //         .map<DropdownMenuEntry<SiteLabels>>(
                        //             (SiteLabels content) {
                        //       return DropdownMenuEntry<SiteLabels>(
                        //         value: content,
                        //         label: content.label,
                        //         style: MenuItemButton.styleFrom(
                        //           foregroundColor: Theme.of(context)
                        //               .colorScheme
                        //               .inversePrimary,
                        //         ),
                        //       );
                        //     }).toList(),
                        //     expandedInsets: const EdgeInsets.all(0),
                        //     onSelected: (value) {
                        //       ref.read(siteValueProvider.notifier).state =
                        //           value!.label;

                        //       print(
                        //         ref.watch(siteValueProvider),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shop",
                          style: TextStyle(fontSize: 20),
                        ),
                        // SizedBox(
                        //   width: 315,
                        //   child: DropdownMenu<ShopLabels>(
                        //     dropdownMenuEntries: ShopLabels.values
                        //         .map<DropdownMenuEntry<ShopLabels>>(
                        //             (ShopLabels content) {
                        //       return DropdownMenuEntry<ShopLabels>(
                        //         value: content,
                        //         label: content.label,
                        //         style: MenuItemButton.styleFrom(
                        //           foregroundColor: Theme.of(context)
                        //               .colorScheme
                        //               .inversePrimary,
                        //         ),
                        //       );
                        //     }).toList(),
                        //     expandedInsets: const EdgeInsets.all(0),
                        //     onSelected: (value) {
                        //       ref.read(shopValueProvider.notifier).state =
                        //           value!.label;

                        //       print(
                        //         ref.watch(shopValueProvider),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Line",
                          style: TextStyle(fontSize: 20),
                        ),
                        // SizedBox(
                        //   width: 315,
                        //   child: DropdownMenu<LineLabels>(
                        //     dropdownMenuEntries: LineLabels.values
                        //         .map<DropdownMenuEntry<LineLabels>>(
                        //             (LineLabels content) {
                        //       return DropdownMenuEntry<LineLabels>(
                        //         value: content,
                        //         label: content.label,
                        //         style: MenuItemButton.styleFrom(
                        //           foregroundColor: Theme.of(context)
                        //               .colorScheme
                        //               .inversePrimary,
                        //         ),
                        //       );
                        //     }).toList(),
                        //     expandedInsets: const EdgeInsets.all(0),
                        //     onSelected: (value) {
                        //       ref.read(lineValueProvider.notifier).state =
                        //           value!.label;

                        //       print(
                        //         ref.watch(lineValueProvider),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Zone",
                          style: TextStyle(fontSize: 20),
                        ),
                        // SizedBox(
                        //   width: 315,
                        //   child: DropdownMenu<ZoneLabels>(
                        //     dropdownMenuEntries: ZoneLabels.values
                        //         .map<DropdownMenuEntry<ZoneLabels>>(
                        //             (ZoneLabels content) {
                        //       return DropdownMenuEntry<ZoneLabels>(
                        //         value: content,
                        //         label: content.label,
                        //         style: MenuItemButton.styleFrom(
                        //           foregroundColor: Theme.of(context)
                        //               .colorScheme
                        //               .inversePrimary,
                        //         ),
                        //       );
                        //     }).toList(),
                        //     expandedInsets: const EdgeInsets.all(0),
                        //     onSelected: (value) {
                        //       ref.read(zoneValueProvider.notifier).state =
                        //           value!.label;

                        //       print(
                        //         ref.watch(zoneValueProvider),
                        //       );
                        //     },
                        //   ),
                        // ),
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
              "assets/icons/Icon_IIR.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
              buttonText: "Next",
              buttonKey: "boothNext",
              width: 100,
              onTap: () {
                // if (siteValue == "" ||
                //     shopValue == "" ||
                //     lineValue == "" ||
                //     zoneValue == "") {
                //   informationSnackBar(
                //       context, Icons.warning, "Please fill in all the fields");
                // } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Anteroom();
                    },
                  ),
                );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
