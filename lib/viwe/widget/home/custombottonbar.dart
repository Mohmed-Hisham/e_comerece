import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Custombottonbar extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final String iconPath;
  final bool isactive;
  const Custombottonbar({
    super.key,
    this.onPressed,
    this.text,
    required this.iconPath,
    required this.isactive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        padding: EdgeInsets.symmetric(
          horizontal: isactive ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isactive
              ? Appcolor.primrycolor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: Appcolor.gray,
                end: isactive ? Appcolor.primrycolor : Appcolor.gray,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, color, child) {
                return SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    color ?? Appcolor.gray,
                    BlendMode.srcIn,
                  ),
                  height: 26.h,
                );
              },
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                width: isactive
                    ? null
                    : 0, // Let it be intrinsic when active, 0 when not
                child: isactive
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$text",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Appcolor.primrycolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
