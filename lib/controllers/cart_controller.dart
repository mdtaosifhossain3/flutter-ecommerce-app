import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;

  var cartItems = [].obs;
  var totalAmount = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getAlldata();

    super.onInit();
  }

  void addProduct(data, selectedVariant) async {
    isLoading.value = true;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user!.email)
        .collection("cart")
        .add({
          "productId": data["id"],
          "name": data["name"],
          "price": data["price"],
          "image": data["image"],
          "variant": selectedVariant,
          "quantity": 1,
          "email": user!.email
        })
        .then((_) => isLoading.value = false)
        .catchError((e, stackTrace) {
          if (kDebugMode) {
            print(e.toString());
          }
          if (kDebugMode) {
            print("The Stack Error:$stackTrace");
          }
        });
  }

  // Method to increase quantity
  void increaseQuantity(data) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.email)
        .collection("cart")
        .doc(data.id)
        .update({"quantity": data["quantity"] + 1}).then(
            (_) => calculateTotalAmount());
  }

  // Method to decrease quantity
  void decreaseQuantity(data) {
    if (data["quantity"] > 1) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(user!.email)
          .collection("cart")
          .doc(data.id)
          .update({
        "quantity": data["quantity"] - 1,
      }).then((_) => calculateTotalAmount());
    } else {
      FirebaseFirestore.instance
          .collection("user")
          .doc(user!.email)
          .collection("cart")
          .doc(data.id)
          .delete()
          .then((_) => calculateTotalAmount());
    }
  }

  getAlldata() async {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.email)
        .collection("cart")
        .snapshots()
        .listen((snapshot) {
      cartItems.value = snapshot.docs;
      calculateTotalAmount();
      isLoading.value = false;
    });
  }

  void calculateTotalAmount() {
    try {
      double amount = cartItems.fold(0, (prev, item) {
        return prev +
            (double.parse(item["price"].replaceAll(',', '')) *
                (item["quantity"]?.toDouble()));
      });
      totalAmount.value = amount;
      print("The is the calucation amount: $amount");
    } catch (e) {
      print("Error calculating total amount: $e");
    }
  }
}
