import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Customtextbody extends StatelessWidget {
  final String text;
  const Customtextbody({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.copyWith(fontSize: 15, color: Appcolor.gray),
      ),
    );
  }
}
