import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var user = FirebaseAuth.instance.currentUser;
  var displayName = ''.obs;
  var photoURL = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.email)
          .get();
      displayName.value = doc['userName'] ?? 'Guest User';
      photoURL.value = doc['photoURL'] ?? user!.photoURL ?? '';
    }
  }

  // Update user profile info
  Future<void> updateProfile(context, String name) async {
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
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user!.email)
            .update({
          'userName': name,
        });
        user!.updateDisplayName(name);

        fetchUserData(); // Refresh data
        Get.snackbar("Success", "Saved Successfully");
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("Error", "Something Went Wrong. Please try again later");
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Update profile image
  Future<void> updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${user!.email}.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.email)
          .update({'photoURL': url});
      user!.updatePhotoURL(url);
      photoURL.value = url;
      fetchUserData(); // Refresh data
    }
  }

  // Method to re-authenticate and change the password
  Future<void> changePassword(
      context, currentPasswordClt, newPasswordClt) async {
    final currentPassword = currentPasswordClt.text.trim();
    final newPassword = newPasswordClt.text.trim();
    if (user == null) {
      Get.snackbar("", 'User not logged in');
      return;
    }

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

    // Re-authenticate user before changing password
    try {
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      await user?.reauthenticateWithCredential(credential);

      // If re-authentication is successful, update the password
      await user?.updatePassword(newPassword);
      Navigator.pop(context);
      Get.snackbar("", 'Password changed successfully');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'wrong-password') {
        Get.snackbar("", 'Current password is incorrect');
      } else {
        Get.snackbar("", 'Failed to change password: ${e.message}');
      }
    } catch (e) {
      Navigator.pop(context);
      Get.snackbar("", 'An error occurred: $e');
    }
  }
}
