import 'package:flutter/material.dart';

class ThreeDMapContainer extends StatelessWidget {
  final String category;
  final String label;
  const ThreeDMapContainer({
    super.key,
    required this.category,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 20),
          ),
          Container(
            width: 300,
            padding: const EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
