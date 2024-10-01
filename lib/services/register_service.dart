import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';
import 'package:uuid/uuid.dart';

class RegisterService {
  final Uuid _uuid = Uuid();
  bool isLoading = false;
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
          isLoading = true;
          final auth = FirebaseAuth.instance;

          final cred = await auth.createUserWithEmailAndPassword(
              email: emailClt.text, password: passwordlClt.text);

          if (cred.user != null) {
            await FirebaseAuth.instance.currentUser!
                .updateDisplayName(userNamelClt.text);

            // Convert to map
            //  Map<String, dynamic> addressMap = address.toMap();

            await FirebaseFirestore.instance
                .collection("user")
                .doc(emailClt.text)
                .set({
              'userName': userNamelClt.text,
              "email": emailClt.text,
              "photoURL": "",
            });
            // Dismiss the loading dialog when successful
            Navigator.pop(context);
            Get.offAll(const BottomBarScreen());

            isLoading = false;
            Get.snackbar("", "Successfully Registered");
            return "Success";
          }

          return;
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
          if (e.code == 'email-already-in-use') {
            Get.snackbar("Error", "The account already exists for that email.");

            return;
          } else if (e.code == 'weak-password') {
            Get.snackbar("Error", "The password provided is too weak.");
            return;
          }
        } on SocketException catch (e) {
          Navigator.pop(context);
          Get.snackbar("Error", "Time Out");
          print(e);
          return;
        } catch (e) {
          Navigator.pop(context);
          Get.snackbar("Error", e.toString());
          return;
        }
      }
    }
  }
}
