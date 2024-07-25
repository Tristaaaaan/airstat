import 'package:flutter/material.dart';

class RegularTextField extends StatelessWidget {
  final String category;
  final String? hinttext;
  final TextEditingController? controller;
  const RegularTextField({
    super.key,
    required this.category,
    this.controller,
    this.hinttext = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                controller: controller,
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
