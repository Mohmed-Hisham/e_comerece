import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/funcations/translate_data.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Custshearchappbar extends StatelessWidget {
  final void Function()? favoriteOnPressed;
  final void Function()? imageOnPressed;
  final void Function()? onTapSearch;
  final void Function()? onTapClose;
  final bool showClose;
  final TextEditingController mycontroller;
  final Function(String)? onChanged;
  const Custshearchappbar({
    super.key,
    this.favoriteOnPressed,
    required this.mycontroller,
    this.onChanged,
    this.onTapSearch,
    this.imageOnPressed,
    this.onTapClose,
    this.showClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 14),
      // height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50),

              child: TextFormField(
                validator: (value) {
                  return vlidateInPut(val: value!, min: 3, max: 100);
                },
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
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showClose)
                        IconButton(
                          onPressed: onTapClose,
                          icon: Icon(Icons.close, color: Appcolor.black2),
                        ),
                      IconButton(
                        onPressed: onTapSearch,
                        icon: Icon(Icons.search, color: Appcolor.primrycolor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: favoriteOnPressed,
            icon: FaIcon(
              langDirection()
                  ? FontAwesomeIcons.heart
                  : FontAwesomeIcons.solidHeart,
              color: langDirection() ? Appcolor.primrycolor : Appcolor.white,
            ),
          ),
          imageOnPressed == null
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: imageOnPressed,
                  icon: Icon(
                    Icons.image_search_rounded,
                    color: Appcolor.white,
                    size: 30,
                  ),
                ),
        ],
      ),
    );
  }
}
