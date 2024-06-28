import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? buttonName;
  final Function? onTap;
  const CustomButton({super.key, this.buttonName, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: size * .9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16)),
          onPressed: () {
            onTap!();
          },
          child: Text(
            buttonName!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
    );
  }
}
