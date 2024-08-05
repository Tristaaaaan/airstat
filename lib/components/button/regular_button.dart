import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegularButton extends ConsumerWidget {
  final String buttonText;
  final void Function()? onTap;
  final bool? withLoading;
  final double? width;
  final String buttonKey;
  const RegularButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.width,
    required this.buttonKey,
    this.withLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider)[buttonKey] ?? false;
    return InkWell(
      onTap: isLoading ? () {} : onTap,
      child: IntrinsicHeight(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: !withLoading!
                ? Theme.of(context).colorScheme.primary
                : !isLoading
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.background),
                )
              : Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: isLoading
                        ? Colors.grey
                        : Theme.of(context).colorScheme.background,
                  ),
                ),
        ),
      ),
    );
  }
}
