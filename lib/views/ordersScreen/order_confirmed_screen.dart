import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.done,
                    color: AppColors.whiteColor,
                    size: 80,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextWidget(
                  label: "Order Confirmed",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Your order has been confirmed, we will send you confirmation email shortly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.greyColor, fontSize: 17),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: CustomButton(
                  fontSize: 17,
                  verticalPadding: 28,
                  radius: 0,
                  width: 1,
                  btnName: "Continue Shopping",
                  onClick: () {
                    Get.offAll(const BottomBarScreen());
                  },
                ))
          ],
        ),
      ),
    );
  }
}
