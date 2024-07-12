import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  const RegularButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: const Text("SAVE"),
      ),
    );
  }
}
