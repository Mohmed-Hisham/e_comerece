import 'package:e_comerece/controller/local_service/view_orders_local_service_controller.dart';
import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LocalServiceOrderState extends StatelessWidget {
  const LocalServiceOrderState({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> statuses = [
      {"key": "pending", "label": "معلق"},
      {"key": "accepted", "label": "مقبول"},
      {"key": "completed", "label": "مكتمل"},
      {"key": "cancelled", "label": "ملغي"},
    ];

    return GetBuilder<ViewOrdersLocalServiceController>(
      builder: (controller) {
        return SizedBox(
          height: 50.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemCount: statuses.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected = controller.currentStatus == status["key"];
              return GestureDetector(
                onTap: () {
                  controller.changeStatus(status["key"]!);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: isSelected ? Appcolor.primrycolor : Appcolor.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Appcolor.primrycolor, width: 1.w),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Appcolor.primrycolor.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      status["label"]!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Appcolor.primrycolor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
