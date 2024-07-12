import 'package:airstat/components/button/regular_button.dart';
import 'package:flutter/material.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Files"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RegularButton(
                buttonText: "Upload",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Open",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Delete",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: RegularButton(
                buttonText: "Export",
                textColor: Theme.of(context).colorScheme.background,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                width: double.infinity,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
