import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExitSilhouette extends ConsumerWidget {
  const ExitSilhouette({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booth",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "Exit Silhouette",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          AirstatSettingsAppBar(),
        ],
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
            Row(
              children: [
                RegularButton(
                  buttonText: "Read",
                  buttonKey: "boothRead",
                  width: 100,
                  withLoading: true,
                  onTap: () async {
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", true);

                    await Future.delayed(const Duration(seconds: 5));
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", false);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                RegularButton(
                  buttonText: "Next",
                  buttonKey: "boothNext",
                  width: 100,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
