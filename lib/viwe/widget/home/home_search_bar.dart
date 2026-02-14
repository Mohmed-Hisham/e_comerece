import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/core/loacallization/translate_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeSearchBar extends StatelessWidget {
  final void Function()? favoriteOnPressed;
  final void Function()? imageOnPressed;

  const HomeSearchBar({super.key, this.favoriteOnPressed, this.imageOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutesname.searchScreen),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Appcolor.somgray,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: StringsKeys.searchHint.tr,
                              style: TextStyle(color: Appcolor.black),
                            ),
                            TextSpan(
                              text: ' ${StringsKeys.searchPlatforms.tr}',
                              style: TextStyle(
                                color: Appcolor.gray,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.diagonal3Values(
                        langDirection() ? 1.0 : -1.0,
                        1.0,
                        1.0,
                      ),
                      child: Icon(Icons.search, color: Appcolor.primrycolor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: favoriteOnPressed,
            icon: FaIcon(
              langDirection()
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
              color: langDirection() ? Appcolor.white : Appcolor.primrycolor,
            ),
          ),
          if (imageOnPressed != null)
            IconButton(
              onPressed: imageOnPressed,
              icon: Icon(
                Icons.image_search_rounded,
                color: langDirection() ? Appcolor.white : Appcolor.primrycolor,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }
}
