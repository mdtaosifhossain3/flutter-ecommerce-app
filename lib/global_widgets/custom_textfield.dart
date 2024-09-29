import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintTextName;
  final bool isTransparent;
  final bool? isRequired;
  final bool? isSecured;
  final TextEditingController? controller;
  final String? initialValue;
  const CustomTextField(
      {super.key,
      this.isTransparent = true,
      this.hintTextName,
      this.isRequired,
      this.initialValue,
      required this.isSecured,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller!..text = initialValue ?? '',
      validator: isRequired == true
          ? (val) {
              if (val!.isEmpty) {
                return "The Field is Required";
              } else {
                return null;
              }
            }
          : null,
      obscureText: isSecured!,
      decoration: InputDecoration(
          hintText: hintTextName,
          filled: true,
          fillColor: AppColors.filledColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 2.00,
                  color: isTransparent
                      ? Colors.transparent
                      : AppColors.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 2.00, color: AppColors.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1.00, color: Colors.red))),
    );
  }
}
