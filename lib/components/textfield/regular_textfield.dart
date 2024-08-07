import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegularTextField extends StatelessWidget {
  final String category;
  final String? hinttext;
  final TextEditingController? controller;
  final bool? number;
  const RegularTextField({
    super.key,
    required this.category,
    this.controller,
    this.hinttext = "",
    this.number = false,
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
                keyboardType: number!
                    ? const TextInputType.numberWithOptions(
                        signed: false, decimal: false)
                    : null,
                inputFormatters:
                    number! ? [FilteringTextInputFormatter.digitsOnly] : null,
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
