import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:e_comerece/core/funcations/validate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Custshearchappbar extends StatelessWidget {
  final void Function()? favoriteOnPressed;
  final void Function()? imageOnPressed;
  final void Function()? onTapSearch;
  final void Function()? onTapClose;
  final bool showClose;
  final bool isLocalService;
  final String? hintText;
  final TextEditingController mycontroller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  const Custshearchappbar({
    super.key,
    this.favoriteOnPressed,
    required this.mycontroller,
    this.onChanged,
    this.onTapSearch,
    this.imageOnPressed,
    this.onTapClose,
    this.showClose = false,
    this.isLocalService = false,
    this.focusNode,
    this.hintText,
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
                  return validateInput(val: value!, min: 3, max: 100);
                },
                focusNode: focusNode,
                onChanged: onChanged,
                controller: mycontroller,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    onTapSearch?.call();
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Appcolor.somgray,
                  hintText: hintText ?? StringsKeys.searchHint.tr,
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
                        icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.diagonal3Values(
                            langDirection() ? 1.0 : -1.0,
                            1.0,
                            1.0,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Appcolor.primrycolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: favoriteOnPressed,
            icon: isLocalService
                ? FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: langDirection()
                        ? Appcolor.white
                        : Appcolor.primrycolor,
                  )
                : FaIcon(
                    langDirection()
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: langDirection()
                        ? Appcolor.white
                        : Appcolor.primrycolor,
                  ),
          ),
          imageOnPressed == null
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: imageOnPressed,
                  icon: Icon(
                    Icons.image_search_rounded,
                    color: langDirection()
                        ? Appcolor.white
                        : Appcolor.primrycolor,
                    size: 30,
                  ),
                ),
        ],
      ),
    );
  }
}
