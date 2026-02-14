import 'dart:developer';

import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/servises/serviese.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PositionedSupport extends StatefulWidget {
  final void Function() onPressed;
  const PositionedSupport({super.key, required this.onPressed});

  @override
  State<PositionedSupport> createState() => _PositionedSupportState();
}

class _PositionedSupportState extends State<PositionedSupport> {
  late double right;
  late double bottom;
  MyServises myServices = Get.find();

  @override
  void initState() {
    super.initState();
    right = -10;
    bottom = 300.h;
    _loadPosition();
  }

  Future<void> _loadPosition() async {
    final savedRight = await myServices.secureStorage.read(
      key: 'support_right',
    );
    final savedBottom = await myServices.secureStorage.read(
      key: 'support_bottom',
    );
    if (!mounted) return;
    setState(() {
      if (savedRight != null) right = double.tryParse(savedRight) ?? -10;
      if (savedBottom != null) bottom = double.tryParse(savedBottom) ?? 300.h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            right -= details.delta.dx;
            bottom -= details.delta.dy;
          });
        },
        onPanEnd: (details) {
          log("right $right");
          log("bottom $bottom");
          myServices.secureStorage.write(
            key: 'support_right',
            value: right.toString(),
          );
          myServices.secureStorage.write(
            key: 'support_bottom',
            value: bottom.toString(),
          );
        },
        onTap: widget.onPressed,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Appcolor.primrycolor,
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            FontAwesomeIcons.headset,
            color: Appcolor.white,
            size: 33.sp,
          ),
        ),
      ),
    );
  }
}
