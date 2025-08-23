import 'package:flutter/material.dart';

class Customtexttitleauth extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  const Customtexttitleauth({super.key, required this.text, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: alignment ?? Alignment.center,
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
