import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custgridviwe extends StatelessWidget {
  final Widget image;
  final String disc;
  final String discprice;
  final String title;
  final String price;
  final Function()? onChangeIcon;
  final Widget icon;
  final String? countsall;
  final bool isAlibaba;
  final Widget? images;
  final String? rate;
  const Custgridviwe({
    super.key,
    required this.image,
    required this.disc,
    required this.title,
    required this.price,
    this.onChangeIcon,
    required this.icon,
    required this.discprice,
    this.countsall,
    this.isAlibaba = false,
    this.images,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isAlibaba
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: images!,
                )
              : const SizedBox.shrink(),

          SizedBox(
            child: Stack(
              children: [
                Container(
                  height: 165,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: image,
                  ),
                ),

                // favorite
                if (countsall != null)
                  Positioned(
                    top: 0,
                    left: -1,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF5790), Color(0xFFF81140)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        countsall.toString(),
                        style: TextStyle(
                          color: Appcolor.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'signika',
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(
                        (0.6.clamp(0.0, 1.0) * 255).round(),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),

                    child: icon,
                  ),
                ),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Appcolor.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Text(
                  price,
                  // "20\$"
                  style: TextStyle(
                    color: Appcolor.primrycolor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'signika',
                    fontSize: 17,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),

              isAlibaba
                  ? Row(
                      spacing: 3,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Appcolor.threecolor,
                          size: 18,
                        ),
                        Text(
                          rate ?? "",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Appcolor.black,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),

          price == discprice
              ? const SizedBox.shrink()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 6,
                  children: [
                    Text(
                      discprice,

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        decorationThickness: 2.0,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          disc,
                          // "20\$"
                          style: TextStyle(
                            color: Appcolor.primrycolor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'signika',
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "OFF",
                          style: TextStyle(
                            fontSize: 13,
                            color: Appcolor.primrycolor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 5,
          //     // shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,

          //     itemBuilder: (context, index) {
          //       return Container(
          //         height: 10,
          //         width: 10,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Appcolor.primrycolor,
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
