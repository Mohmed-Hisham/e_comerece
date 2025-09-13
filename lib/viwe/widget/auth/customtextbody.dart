import 'package:flutter/material.dart';

class Customtextbody extends StatelessWidget {
  final String text;
  final AlignmentGeometry? alignment;
  const Customtextbody({super.key, required this.text, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 15,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
