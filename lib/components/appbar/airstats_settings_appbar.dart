import 'package:flutter/material.dart';

class AirstatSettingsAppBar extends StatelessWidget {
  const AirstatSettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Row(
          children: [
            Text(
              "Sampling: ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sampling",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Text(
              "Delay: ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sampling",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Row(
          children: [
            Text(
              "Units: ",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sampling",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
