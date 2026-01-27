import 'package:e_comerece/core/constant/color.dart';
import 'package:e_comerece/core/loacallization/strings_keys.dart';
import 'package:e_comerece/viwe/screen/local_serviess/orders/widget/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final String note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: StringsKeys.notesTitle.tr,
      icon: Icons.note,
      children: [
        Text(
          note,
          style: TextStyle(fontSize: 14.sp, color: Appcolor.black),
        ),
      ],
    );
  }
}
