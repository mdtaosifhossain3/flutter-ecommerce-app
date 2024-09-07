import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final String btnName;
  final double? fontSize;
  final double? radius;
  final String? icon;
  final width;
  final double? verticalPadding;
  final Function? onClick;

  const CustomButton({
    super.key,
    this.verticalPadding,
    this.radius,
    this.fontSize,
    this.icon,
    this.bgColor,
    this.width,
    required this.btnName,
    this.textColor,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width != null ? size * width : size * .4,
      child: TextButton(
          onPressed: () {
            onClick!();
          },
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(bgColor ?? AppColors.primaryColor),
              foregroundColor:
                  const WidgetStatePropertyAll(AppColors.whiteColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10))),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                vertical: verticalPadding ?? 18,
              ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) Image.asset(icon.toString()),
              const SizedBox(
                width: 5,
              ),
              Text(
                btnName,
                style: TextStyle(
                    color: textColor ?? AppColors.whiteColor,
                    fontSize: fontSize),
              ),
            ],
          )),
    );
  }
}

/**
 * 
 * 
 * SizedBox(
      width: size * .9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: bgColor,
              foregroundColor: AppColors.whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 16)),
          onPressed: () {
            onClick!();
          },
          child: Text(
            btnName,
            style: TextStyle(color: textColor),
          )),
    );
 */



