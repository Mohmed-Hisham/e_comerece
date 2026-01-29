import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custtextfeld extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;

  const Custtextfeld({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText,
    this.onChanged,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: TextFormField(
          autofocus: false,
          focusNode: focusNode,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          validator: validator,
          controller: controller,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Appcolor.somgray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Appcolor.somgray),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Appcolor.reed),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Appcolor.reed),
            ),
            filled: true,
            fillColor: Appcolor.somgray,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorStyle: TextStyle(color: Appcolor.reed, fontSize: 12),
            errorMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
