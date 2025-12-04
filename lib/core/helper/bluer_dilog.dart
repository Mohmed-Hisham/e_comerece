import 'package:flutter/material.dart';
import 'package:d_dialog/d_dialog.dart';

blurDilog(Widget content, BuildContext context) {
  DialogBackground(
    blur: 5,
    barrierColor: Colors.black.withValues(alpha: 0.2),
    dialog: content,
  ).show(
    context,
    transitionType: DialogTransitionType.rightToLeft,
    transitionDuration: const Duration(milliseconds: 400),
  );
}
