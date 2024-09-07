import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';

class RegisterService {
  regiser(context, passwordlClt, confirmpasswordlClt, emailClt, userNamelClt,
      formState) async {
    if (formState.currentState!.validate()) {
      if (passwordlClt.text != confirmpasswordlClt.text) {
        Get.snackbar("", "Password is not Matched");
      } else {
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
          final auth = FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(
              email: emailClt.text, password: passwordlClt.text);

          await FirebaseAuth.instance.currentUser!
              .updateDisplayName(userNamelClt.text);

          FirebaseFirestore.instance
              .collection("user")
              .doc(emailClt.text)
              .set({'userName': userNamelClt.text, "email": emailClt.text});
          Get.offAll(const BottomBarScreen());

          Get.snackbar("", "Successfully Registered");
        } on FirebaseAuthException catch (e) {
          if (e.code == "email-alredy-in-use") {
            Get.snackbar("", "Email alredy exsists");
          }
        } catch (e) {
          Get.snackbar("Error", e.toString());
        }
      }
    }
  }
}
