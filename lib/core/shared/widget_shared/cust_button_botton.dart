import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustButtonBotton extends StatelessWidget {
  final String? title;
  final void Function() onTap;

  const CustButtonBotton({super.key, required this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Appcolor.primrycolor, width: 1.5),
        ),
        child: Text(
          title ?? "Cancel",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: title == null ? Appcolor.gray : Appcolor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
