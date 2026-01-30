import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceRequestTrackingWidget extends StatelessWidget {
  final String currentStatus;

  const ServiceRequestTrackingWidget({super.key, required this.currentStatus});

  List<TrackingStep> _getTrackingSteps() {
    return [
      TrackingStep(
        status: 'new',
        title: StringsKeys.newService.tr,
        icon: Icons.new_releases_outlined,
      ),
      TrackingStep(
        status: 'in_chat',
        title: StringsKeys.inChat.tr,
        icon: Icons.chat_outlined,
      ),
      TrackingStep(
        status: 'price_quoted',
        title: StringsKeys.quotedPrice.tr,
        icon: Icons.attach_money,
      ),
      TrackingStep(
        status: 'approved',
        title: StringsKeys.statusApproved.tr,
        icon: Icons.check_circle_outline,
      ),
      TrackingStep(
        status: 'completed',
        title: StringsKeys.statusCompleted.tr,
        icon: Icons.done_all,
      ),
    ];
  }

  int _getCurrentStepIndex() {
    final steps = _getTrackingSteps();
    final index = steps.indexWhere((step) => step.status == currentStatus);
    // If status is not found (e.g. cancelled), or if it matches, return index.
    // Logic below handles 'cancelled' separately, so this index is for the steps progress.
    if (index == -1) {
      // If we want 'completed' to show full progress, checks are needed.
      // But for linear progression, if status is 'cancelled', index is -1.
      return 0;
    }
    return index;
  }

  Color _getStepColor(int stepIndex, int currentIndex) {
    if (currentStatus == 'cancelled') {
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

    // Handle cancelled status
    if (currentStatus == 'cancelled' || currentStatus == 'rejected') {
      return _buildRejectedOrCancelledStatus();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
            StringsKeys.trackService.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Appcolor.black,
            ),
          ),
          SizedBox(height: 20.h),

          // Tracking Steps
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(steps.length * 2 - 1, (index) {
                if (index.isOdd) {
                  // Connector line
                  final lineIndex = index ~/ 2;
                  return Container(
                    width: 30.w, // Fixed width for connector
                    height: 2,
                    color: _getStepColor(lineIndex + 1, currentIndex),
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
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? stepColor : Appcolor.white,
                          border: Border.all(color: stepColor, width: 2),
                        ),
                        child: Icon(
                          step.icon,
                          color: isActive ? Appcolor.white : stepColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        width: 60.w,
                        child: Text(
                          step.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
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
          ),
        ],
      ),
    );
  }

  Widget _buildRejectedOrCancelledStatus() {
    final isRejected = currentStatus == 'rejected';
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
                      ? StringsKeys.serviceRejected.tr
                      : StringsKeys.serviceCancelled.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isRejected ? Appcolor.reed : Appcolor.gray,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  isRejected
                      ? StringsKeys.requestRejectedByAdmin.tr
                      : StringsKeys.serviceCancelledMessage.tr,
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
