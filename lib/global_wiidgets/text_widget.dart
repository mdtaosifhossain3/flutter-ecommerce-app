import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? icon;
  const TextWidget(
      {super.key,
      this.color,
      this.fontSize = 18,
      this.fontWeight,
      this.textAlign,
      this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Image.asset(icon.toString()),
        SizedBox(
          width: 5,
        ),
        Text(
          label,
          textAlign: textAlign ?? TextAlign.left,
          style: TextStyle(
              color: color ?? AppColors.blackColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.normal),
        ),
      ],
    );
  }
}
