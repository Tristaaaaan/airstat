import 'package:airstat/main/continuous/continuous_reading_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegularButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isReading = ref.watch(isReadingProvider);
    return InkWell(
      onTap: isReading ? () {} : onTap,
      child: IntrinsicHeight(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: isReading
              ? const CircularProgressIndicator()
              : Text(
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
