import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  final String image;
  final String label;
  const MenuContainer({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(5),
      child: Center(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Image.asset(
                  image,
                  width: 75,
                  height: 75,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
