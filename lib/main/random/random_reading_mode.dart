import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/main/random/random_reading_page.dart';
import 'package:flutter/material.dart';

class RandomReadingMode extends StatelessWidget {
  const RandomReadingMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random"),
      ),
      body: const Center(
        child: Column(
          children: [RegularTextField(category: "Zone ID")],
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
              "assets/icons/Icon_random_orange.png",
              width: 50,
              height: 50,
            ),
            RegularButton(
              buttonText: "Next",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RandomReadingPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}