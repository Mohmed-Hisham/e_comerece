import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custtextfeld extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;

  const Custtextfeld({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50),
        child: TextFormField(
          obscureText: obscureText ?? false,
          validator: validator,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            suffixIcon: suffixIcon,
            errorStyle: TextStyle(color: Appcolor.reed, fontSize: 12),
            errorMaxLines: 2,
          ),
        ),
      ),
    );
  }
}
