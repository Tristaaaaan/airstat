import 'package:flutter/material.dart';

class RegularButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  const RegularButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(color: backgroundColor),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
