import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/main/booth/entrance_silhouette_page.dart';
import 'package:flutter/material.dart';

enum SiteLabels {
  cincinatti('Cincinatti');

  const SiteLabels(this.label);

  final String label;
}

enum ShopLabels {
  paintShop1('Paint Shop 1');

  const ShopLabels(this.label);

  final String label;
}

enum LineLabels {
  topCoat1('Topcoat1');

  const LineLabels(this.label);

  final String label;
}

enum ZoneLabels {
  baseExt1('BaseExt1');

  const ZoneLabels(this.label);

  final String label;
}

class BoothPage extends StatelessWidget {
  const BoothPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child: DropdownMenu<SiteLabels>(
                            dropdownMenuEntries: SiteLabels.values
                                .map<DropdownMenuEntry<SiteLabels>>(
                                    (SiteLabels content) {
                              return DropdownMenuEntry<SiteLabels>(
                                value: content,
                                label: content.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                          "Shop",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<ShopLabels>(
                            dropdownMenuEntries: ShopLabels.values
                                .map<DropdownMenuEntry<ShopLabels>>(
                                    (ShopLabels content) {
                              return DropdownMenuEntry<ShopLabels>(
                                value: content,
                                label: content.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                          "Line",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<LineLabels>(
                            dropdownMenuEntries: LineLabels.values
                                .map<DropdownMenuEntry<LineLabels>>(
                                    (LineLabels content) {
                              return DropdownMenuEntry<LineLabels>(
                                value: content,
                                label: content.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                          "Zone",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<ZoneLabels>(
                            dropdownMenuEntries: ZoneLabels.values
                                .map<DropdownMenuEntry<ZoneLabels>>(
                                    (ZoneLabels content) {
                              return DropdownMenuEntry<ZoneLabels>(
                                value: content,
                                label: content.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EntranceSilhouette();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
