import 'package:flutter/material.dart';

Future<void> scrollWhenKeyboardOpens(
  ScrollController scrollController,
  BuildContext context,
  double offset, {
  Duration timeout = const Duration(seconds: 1),
}) async {
  if (!scrollController.hasClients) return;

  final end = DateTime.now().add(timeout);

  if (MediaQuery.of(context).viewInsets.bottom > 0) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    return;
  }

  while (DateTime.now().isBefore(end)) {
    await Future.delayed(const Duration(milliseconds: 50));
    if (context.mounted) {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        return;
      }
    }
  }
}
