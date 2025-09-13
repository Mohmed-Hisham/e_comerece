import 'package:flutter/material.dart';
import 'package:e_comerece/core/constant/color.dart';

class Custmenubutton<T> extends StatelessWidget {
  final List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder;
  final void Function(T?)? onSelected;

  const Custmenubutton({super.key, required this.itemBuilder, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      constraints: BoxConstraints(maxHeight: 250),
      position: PopupMenuPosition.over,
      borderRadius: BorderRadius.circular(10),
      shape: ShapeBorder.lerp(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        0.5,
      ),
      icon: Icon(Icons.arrow_drop_down, size: 25, color: Appcolor.black),
      onSelected: onSelected,
      itemBuilder: itemBuilder,
    );
  }
}
