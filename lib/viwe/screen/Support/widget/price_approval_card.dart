import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/viwe/widget/auth/custombuttonauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceApprovalCard extends StatelessWidget {
  final String price;
  final VoidCallback onConfirm;

  const PriceApprovalCard({
    super.key,
    required this.price,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Appcolor.primrycolor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.monetization_on_outlined, color: Appcolor.primrycolor),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Price Approved: $price",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Appcolor.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Custombuttonauth(inputtext: "Complete Order", onPressed: onConfirm),
        ],
      ),
    );
  }
}
