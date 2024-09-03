import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_button.dart';
import 'package:mini_ecommerce/global_wiidgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/authentication/registerScreen/register_screen.dart';
import 'package:mini_ecommerce/views/getStartedScreen/get_started_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/welcome-screen-logo.png"))),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.00, vertical: 20),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 35, top: 20),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.00)),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const TextWidget(
                    label: "Look Good,Feel Good",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(
                    label:
                        "Create your individual & unique style and \n look amazing everyday.",
                    color: AppColors.greyColor,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        btnName: "Men",
                        textColor: AppColors.greyColor,
                        bgColor: const Color(0xffF5F6FA),
                        onClick: () {
                          Get.to(const GetStartedScreen());
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CustomButton(
                        btnName: "Women",
                        textColor: Colors.white,
                        bgColor: AppColors.primaryColor,
                        onClick: () {
                          Get.to(const GetStartedScreen());
                        },
                      )
                    ],
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
