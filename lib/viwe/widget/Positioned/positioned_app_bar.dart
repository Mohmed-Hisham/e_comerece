import 'package:flutter/material.dart';

class PositionedAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double? top;
  const PositionedAppBar({
    super.key,
    this.onPressed,
    required this.title,
    this.top = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Row(
        spacing: 10,
        children: [
          SizedBox(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_back_rounded, color: Colors.black, size: 27),
          ),

          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
