import 'package:flutter/material.dart';

class MeasureReadingRandom extends StatelessWidget {
  final String label;
  const MeasureReadingRandom({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/icon_dd1.png",
                width: 35,
                height: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "--.-",
                style: TextStyle(fontSize: 70),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/icon_cd1.png",
                width: 35,
                height: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "--.-",
                style: TextStyle(fontSize: 70),
              )
            ],
          ),
        )
      ],
    );
  }
}
