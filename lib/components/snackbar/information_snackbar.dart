// Information SnackBar, used to show information using a snackbar
import 'package:flutter/material.dart';

void informationSnackBar(
  BuildContext context,
  IconData icon,
  String text,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ],
          ),
          IconButton(
            color: Theme.of(context).colorScheme.background,
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 4,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
  );
}
