import 'package:flutter/material.dart';

class BoxDataContainer extends StatelessWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;

  const BoxDataContainer({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            value == "" ? "--.-" : value,
            style: TextStyle(fontSize: value == "" ? 25 : 18),
          ),
        ),
      ),
    );
  }
}
