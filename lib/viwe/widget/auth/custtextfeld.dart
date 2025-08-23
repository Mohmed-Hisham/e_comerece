import 'package:e_comerece/core/constant/color.dart';
import 'package:flutter/material.dart';

class Custtextfeld extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?) validator;
  final bool? obscureText;
  final Widget? suffix;
  const Custtextfeld({
    super.key,
    required this.hint,
    this.controller,
    this.suffixIcon,
    required this.validator,
    this.obscureText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: obscureText ?? false,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          suffix: suffix,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.somgray),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Appcolor.somgray),
          ),
          filled: true,
          fillColor: Appcolor.somgray,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
