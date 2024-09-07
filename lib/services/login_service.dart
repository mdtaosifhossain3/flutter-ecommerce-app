import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';

class LoginService {
  login(context, formState, emailClt, passwordClt) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Dialog(
              backgroundColor: Colors.transparent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(),
                  ]),
            );
          });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailClt.text, password: passwordClt.text);

        Get.offAll(const BottomBarScreen());

        Get.snackbar("Success", "Login Succesfully");
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", e.toString());
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
