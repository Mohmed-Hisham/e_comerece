import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemInfo extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onShowMore;

  const CartItemInfo({
    super.key,
    required this.title,
    required this.price,
    required this.onShowMore,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "asian",
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: onShowMore,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Appcolor.gray),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "more".tr, // Added .tr for consistency
                    style: const TextStyle(
                      height: 1.1,
                      color: Appcolor.primrycolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
