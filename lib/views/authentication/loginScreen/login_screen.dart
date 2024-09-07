import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/custom_textfield.dart';
import 'package:mini_ecommerce/services/login_service.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/registerScreen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailClt = TextEditingController();
  final passwordClt = TextEditingController();

  final _formState = GlobalKey<FormState>();

  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15.00),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                children: [
                  Text(
                    "Login Here",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text("Welcome back you’ve\n been missed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Form(
                key: _formState,
                child: Column(children: [
                  CustomTextField(
                      hintTextName: "Email Address",
                      isSecured: false,
                      controller: emailClt,
                      isRequired: true,
                      isTransparent: true),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      hintTextName: "Password",
                      isSecured: true,
                      controller: passwordClt,
                      isRequired: true,
                      isTransparent: true),
                  const SizedBox(
                    height: 29,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot your password?",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ]),
              ),
              CustomButton(
                onClick: () {
                  _loginService.login(
                      context, _formState, emailClt, passwordClt);
                },
                btnName: 'Login',
                width: 1,
                fontSize: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create new Account",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const RegisterScreen());
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
