import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custshearchappbar extends StatelessWidget {
  final void Function()? favoriteOnPressed;
  final void Function()? onTapSearch;
  final TextEditingController mycontroller;
  final Function(String)? onChanged;
  const Custshearchappbar({
    super.key,
    this.favoriteOnPressed,
    required this.mycontroller,
    this.onChanged,
    this.onTapSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 14),
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 280,
            child: TextFormField(
              onChanged: onChanged,
              controller: mycontroller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Appcolor.somgray,
                hintText: "Shearch item",
                hintStyle: TextStyle(color: Appcolor.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Appcolor.somgray),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Appcolor.somgray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Appcolor.somgray, width: 1.5),
                ),
                suffixIcon: IconButton(
                  onPressed: onTapSearch,
                  icon: Icon(Icons.search, color: Appcolor.black2),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: favoriteOnPressed,
            icon: Icon(Icons.favorite, color: Appcolor.white, size: 30),
          ),
        ],
      ),
    );
  }
}
