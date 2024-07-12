import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  final String category;
  final String hinttext;
  const RegularTextField({
    super.key,
    required this.category,
    required this.hinttext,
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
          IntrinsicHeight(
            child: SizedBox(
              width: 315,
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: hinttext,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
