import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/authentication/registerScreen/register_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Lets get started"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomButton(
                    btnName: "Google",
                    width: 1,
                    bgColor: AppColors.googleButtonColor,
                    icon: 'assets/icons/Google.png',
                    onClick: () {
                      Get.snackbar(
                          "Message", "This Feature will be available soon.");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    btnName: "Facebook",
                    width: 1,
                    icon: 'assets/icons/Facebook.png',
                    bgColor: AppColors.facebookButtonColor,
                    onClick: () {
                      Get.snackbar(
                          "Message", "This Feature will be available soon.");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    btnName: "Twitter",
                    width: 1,
                    icon: 'assets/icons/Twitter.png',
                    bgColor: AppColors.twitterButtonColor,
                    onClick: () {
                      Get.snackbar(
                          "Message", "This Feature will be available soon.");
                    },
                  )
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextWidget(
                      label: "Already Have an Account?",
                      fontSize: 15,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(const LoginScreen());
                        },
                        child: const TextWidget(
                          label: "Login",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  btnName: "Create An Account",
                  width: 1,
                  radius: 0,
                  verticalPadding: 25,
                  onClick: () {
                    Get.to(const RegisterScreen());
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
