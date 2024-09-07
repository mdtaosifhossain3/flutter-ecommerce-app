import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/custom_textfield.dart';
import 'package:mini_ecommerce/services/register_service.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formState = GlobalKey<FormState>();

  final userNamelClt = TextEditingController();
  final emailClt = TextEditingController();
  final passwordlClt = TextEditingController();
  final confirmpasswordlClt = TextEditingController();

  final RegisterService _registerService = RegisterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, bgColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding:
              const EdgeInsets.only(left: 15.00, right: 15.00, bottom: 15.00),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        "Create an account so you can explore all the existing jobs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.5))),
                  ],
                ),
                const SizedBox(
                  height: 53,
                ),
                Form(
                  key: _formState,
                  child: Column(children: [
                    CustomTextField(
                        hintTextName: "username",
                        isTransparent: false,
                        isRequired: true,
                        isSecured: false,
                        controller: userNamelClt),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomTextField(
                        hintTextName: "Email Address",
                        isTransparent: true,
                        isRequired: true,
                        isSecured: false,
                        controller: emailClt),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomTextField(
                      hintTextName: "Password",
                      isRequired: true,
                      isSecured: true,
                      controller: passwordlClt,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    CustomTextField(
                      hintTextName: "Confirm Password",
                      isRequired: true,
                      isSecured: true,
                      controller: confirmpasswordlClt,
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    CustomButton(
                      onClick: () {
                        _registerService.regiser(
                          context,
                          passwordlClt,
                          confirmpasswordlClt,
                          emailClt,
                          userNamelClt,
                          _formState,
                        );
                      },
                      btnName: 'Register',
                      width: 1,
                      verticalPadding: 25,
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const LoginScreen());
                      },
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
