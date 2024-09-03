import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_button.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_textfield.dart';
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
  final _auth = FirebaseAuth.instance;
  final userNamelClt = TextEditingController();
  final emailClt = TextEditingController();
  final passwordlClt = TextEditingController();
  final confirmpasswordlClt = TextEditingController();
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
                      onClick: () async {
                        if (_formState.currentState!.validate()) {
                          if (passwordlClt.text != confirmpasswordlClt.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Password is not Matched")));
                          } else {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: emailClt.text,
                                  password: passwordlClt.text);

                              await FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(userNamelClt.text);
                              await FirebaseAuth.instance.currentUser!
                                  .updateEmail(emailClt.text);

                              FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(emailClt.text)
                                  .set({
                                'userName': userNamelClt.text,
                                "email": emailClt.text
                              });
                              Get.offAll(const BottomBarScreen());

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Successfully Registered")));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "email-alredy-in-use") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Email alredy exsists")));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        }
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
