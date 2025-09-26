import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_comerece/core/constant/imagesassets.dart';
import 'package:e_comerece/core/constant/routesname.dart';
import 'package:e_comerece/core/shared/widget_shared/custcarouselslider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Custcarouselslider(items: [AppImagesassets.tset]),

        SizedBox(height: 10),
        GridView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisExtent: 100,
            mainAxisSpacing: 10,
          ),
          children: [
            Image.asset(AppImagesassets.shein, height: 80, width: 300),
            InkWell(
              onTap: () => Get.toNamed(AppRoutesname.Homepagealibaba),
              child: Image.asset(
                AppImagesassets.alibab,
                height: 100,
                width: 200,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutesname.homepage1);
              },
              child: Image.asset(
                AppImagesassets.aliexpress,
                height: 100,
                width: 200,
              ),
            ),
            Image.asset(AppImagesassets.amazon, height: 100, width: 200),
          ],
        ),
        SizedBox(height: 5),
        Text("   Best from AliExpress"),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(left: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5),
        Text("   Best from Alibaba"),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(left: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
