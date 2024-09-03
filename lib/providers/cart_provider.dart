import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  List item = [];

  void addProduct(data, selectedVariant) async {
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
        .then((value) => print("added"))
        .catchError((e, stackTrace) {
          if (kDebugMode) {
            print(e.toString());
          }
          if (kDebugMode) {
            print("The Stack Error:$stackTrace");
          }
        });

    notifyListeners();
  }

  getAlldata() async {
    final getData = await FirebaseFirestore.instance
        .collection("user")
        .doc(user!.email)
        .collection("cart")
        .get();
    item.addAll(getData.docs);
  }

  double total() {
    return item.fold(
      0.0, // Or any other non-null default value
      (prev, item) =>
          double.parse(prev.toString()) +
          double.parse((item['price']).toString()),
    );
  }
}
