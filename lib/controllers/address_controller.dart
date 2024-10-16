import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/models/address_model.dart';

class AddressController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  // Text editing controllers for each field
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateController = TextEditingController();
  RxBool isDefault = true.obs; // For the default checkbox state

  @override
  void onClose() {
    // Dispose all controllers when the controller is closed
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    countryController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    postalCodeController.dispose();
    stateController.dispose();
    super.onClose();
  }

  // Method to submit the form and add address to Firestore
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        if (user != null) {
          // Prepare address data
          final data = AddressModel(
              addressLine1: addressLine1Controller.text,
              addressLine2: addressLine2Controller.text,
              city: cityController.text,
              country: countryController.text,
              fullName: fullNameController.text,
              isDefault: isDefault.value,
              phoneNumber: phoneNumberController.text,
              postalCode: postalCodeController.text,
              state: stateController.text);

          final addressData = data.toJson();

          // Add address to Firestore
          await FirebaseFirestore.instance
              .collection("user")
              .doc(user!.email)
              .collection("address")
              .add(addressData);

          // Success message
          Get.back();
          Get.snackbar('Success', 'Address added successfully',
              snackPosition: SnackPosition.BOTTOM);

          addressLine1Controller.clear();
          addressLine2Controller.clear();
          cityController.clear();
          countryController.clear();
          fullNameController.clear();
          postalCodeController.clear();
          phoneNumberController.clear();
          stateController.clear();
        } else {
          Get.snackbar('Error', 'User not logged in',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to add address: $e',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Validation error message
      Get.snackbar('Error', 'Please fill all required fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> deleteAddress(id) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user!.email)
          .collection("address")
          .doc(id)
          .delete();
      Get.snackbar("Success", "Address Deleted",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Method to edit the form and add address to Firestore
  Future<void> editForm(id) async {
    if (formKey.currentState!.validate()) {
      try {
        if (user != null) {
          // Prepare address data
          Map<String, dynamic> addressData = {
            'addressLine1': addressLine1Controller.text,
            'addressLine2': addressLine2Controller.text,
            'city': cityController.text,
            'country': countryController.text,
            'fullName': fullNameController.text,
            'isDefault': isDefault.value,
            'phoneNumber': phoneNumberController.text,
            'postalCode': postalCodeController.text,
            'state': stateController.text,
          };

          // Add address to Firestore
          await FirebaseFirestore.instance
              .collection("user")
              .doc(user!.email)
              .collection("address")
              .doc(id)
              .update(addressData);

          // Success message
          Get.back();
          Get.snackbar('Success', 'Address edited successfully',
              snackPosition: SnackPosition.BOTTOM);

          addressLine1Controller.clear();
          addressLine2Controller.clear();
          cityController.clear();
          countryController.clear();
          fullNameController.clear();
          postalCodeController.clear();
          phoneNumberController.clear();
          stateController.clear();
        } else {
          Get.snackbar('Error', 'User not logged in',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to add address: $e',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // Validation error message
      Get.snackbar('Error', 'Please fill all required fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
