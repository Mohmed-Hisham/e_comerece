import 'package:e_comerece/controller/aliexpriess/searchbyimage_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/wantedcategory.dart';
import 'package:flutter/material.dart';

class CategorylistForImagesearch extends StatelessWidget {
  final SearchByimageControllerllerImple controller;
  const CategorylistForImagesearch({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      scrollDirection: Axis.horizontal,
      itemCount: controller.catgories.length,
      itemBuilder: (context, index) {
        final cat = controller.catgories[index];

        final IconData iconToShow =
            categoryIcons[int.tryParse(cat.id.toString())] ??
            Icons.category_outlined;

        return Container(
          width: 100,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      int id = int.parse(cat.id.toString());
                      controller.gotoshearchname(cat.name ?? "", id);
                    },

                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        border: Border.all(
                          color: cat.selected == true
                              ? Appcolor.primrycolor
                              : Appcolor.threecolor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(iconToShow, color: Appcolor.black2),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(4),
                width: 100,
                child: Text(
                  cat.name!,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Appcolor.soecendcolor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
