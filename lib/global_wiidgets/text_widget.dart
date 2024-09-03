import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const TextWidget(
      {super.key,
      this.color,
      this.fontSize = 18,
      this.fontWeight,
      this.textAlign,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
          color: color ?? AppColors.blackColor,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
