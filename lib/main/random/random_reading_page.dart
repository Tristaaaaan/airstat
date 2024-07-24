import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/measure_random_reading_container.dart';
import 'package:flutter/material.dart';

class RandomReadingPage extends StatelessWidget {
  const RandomReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MeasureReadingRandom(label: "Measurement 1"),
            MeasureReadingRandom(label: "Measurement 2"),
            MeasureReadingRandom(label: "Measurement 3"),
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
              "assets/icons/Icon_continuous_orange.png",
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                RegularButton(
                  buttonText: "Stop",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                RegularButton(
                  buttonText: "Read",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: 100,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                RegularButton(
                  buttonText: "Save",
                  textColor: Theme.of(context).colorScheme.background,
                  backgroundColor: Theme.of(context).colorScheme.primary,
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
