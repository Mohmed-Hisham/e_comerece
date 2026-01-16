import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/constant/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderTrackingWidget extends StatelessWidget {
  final String currentStatus;

  const OrderTrackingWidget({super.key, required this.currentStatus});

  List<TrackingStep> _getTrackingSteps() {
    return [
      TrackingStep(
        status: 'pendingreview',
        title: 'مراجعة',
        icon: Icons.assignment_ind_outlined,
      ),
      TrackingStep(
        status: 'approved',
        title: 'موافقة',
        icon: Icons.check_circle_outline,
      ),
      TrackingStep(
        status: 'processing',
        title: 'تجهيز',
        icon: Icons.inventory_2_outlined,
      ),
      TrackingStep(
        status: 'intransit',
        title: 'توصيل',
        icon: Icons.local_shipping_outlined,
      ),
      TrackingStep(status: 'completed', title: 'استلام', icon: Icons.task_alt),
    ];
  }

  int _getCurrentStepIndex() {
    final status = currentStatus.toLowerCase();
    switch (status) {
      case 'pendingreview':
      case 'adminnotes':
      case 'pending_approval': // legacy
        return 0;
      case 'approved':
      case 'awaitingpayment':
      case 'paid':
        return 1;
      case 'processing':
        return 2;
      case 'intransit':
        return 3;
      case 'completed':
        return 4;
      default:
        // Check if it matches any step status directly
        final steps = _getTrackingSteps();
        final index = steps.indexWhere((step) => step.status == status);
        return index == -1 ? 0 : index;
    }
  }

  Color _getStepColor(int stepIndex, int currentIndex) {
    if (currentStatus == 'rejected' || currentStatus == 'declined') {
      return Appcolor.reed;
    } else if (currentStatus == 'cancelled') {
      return Appcolor.gray;
    } else if (stepIndex <= currentIndex) {
      return Appcolor.primrycolor;
    }
    return Appcolor.gray.withValues(alpha: 0.3);
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getTrackingSteps();
    final currentIndex = _getCurrentStepIndex();

    // Handle rejected or cancelled status
    if (currentStatus == 'rejected' ||
        currentStatus == 'declined' ||
        currentStatus == 'cancelled') {
      return _buildRejectedOrCancelledStatus();
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appcolor.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title
          Text(
            StringsKeys.orderTrackingTitle.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          SizedBox(height: 20.h),

          // Tracking Steps
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isOdd) {
                // Connector line
                final lineIndex = index ~/ 2;
                return Expanded(
                  child: Container(
                    height: 2,
                    color: _getStepColor(lineIndex + 1, currentIndex),
                  ),
                );
              } else {
                // Step circle
                final stepIndex = index ~/ 2;
                final step = steps[stepIndex];
                final isActive = stepIndex <= currentIndex;
                final stepColor = _getStepColor(stepIndex, currentIndex);

                return Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? stepColor : Appcolor.white,
                        border: Border.all(color: stepColor, width: 2),
                      ),
                      child: Icon(
                        step.icon,
                        color: isActive ? Appcolor.white : stepColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        step.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isActive ? stepColor : Appcolor.gray,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectedOrCancelledStatus() {
    final isRejected =
        currentStatus == 'rejected' || currentStatus == 'declined';
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Appcolor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isRejected ? Appcolor.reed : Appcolor.gray,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRejected
                  ? Appcolor.reed.withValues(alpha: 0.1)
                  : Appcolor.gray.withValues(alpha: 0.1),
            ),
            child: Icon(
              isRejected ? Icons.cancel_outlined : Icons.block,
              color: isRejected ? Appcolor.reed : Appcolor.gray,
              size: 28.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isRejected
                      ? StringsKeys.orderStatusRejectedTitle.tr
                      : StringsKeys.orderStatusCancelledTitle.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isRejected ? Appcolor.reed : Appcolor.gray,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isRejected
                      ? StringsKeys.orderRejectedBody.tr
                      : StringsKeys.orderCancelledBody.tr,
                  style: TextStyle(fontSize: 14.sp, color: Appcolor.gray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrackingStep {
  final String status;
  final String title;
  final IconData icon;

  TrackingStep({required this.status, required this.title, required this.icon});
}
