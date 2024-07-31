import 'package:flutter/material.dart';

class MeasureReadingRandom extends StatelessWidget {
  final String label;
  final String downDraft;
  final String crossDraft;
  const MeasureReadingRandom({
    super.key,
    required this.label,
    required this.downDraft,
    required this.crossDraft,
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
              Text(
                downDraft.isNotEmpty ? downDraft : "--.-",
                style: const TextStyle(fontSize: 70),
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
              Text(
                crossDraft.isNotEmpty ? crossDraft : "--.-",
                style: const TextStyle(fontSize: 70),
              )
            ],
          ),
        )
      ],
    );
  }
}
