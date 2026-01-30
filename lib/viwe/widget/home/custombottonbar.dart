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
    final color = isactive ? Appcolor.primrycolor : Appcolor.gray;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
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
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              height: 26.h,
            ),
            if (isactive) ...[
              const SizedBox(width: 8),
              Text(
                text ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Appcolor.primrycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
