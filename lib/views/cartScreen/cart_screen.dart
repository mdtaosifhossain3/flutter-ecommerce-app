import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_button.dart';
import 'package:mini_ecommerce/providers/cart_provider.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final user = FirebaseAuth.instance.currentUser;

  List<QueryDocumentSnapshot> cartItems = [];
  double? totalAmount = 0.00;

  double calculateAmount() {
    // cartItems.fold(0.00, (prev, item) => double.parse(prev.toString()) + double.parse((item.get(field)).toString()));
    for (var data in cartItems) {
      num price = NumberFormat().parse(data["price"]);
      num quantity = data["quantity"];

      //print(price * quantity); worked

      // finalAmount += price * quantity;
      // totalAmount = finalAmount;
    }
    return 0.00;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    final size = MediaQuery.sizeOf(context).width;

    // print(cartItems.first.);
    print("hi");
    print(cartProvider.item);

    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(user!.email)
                .collection("cart")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    cartItems = snapshot.data!.docs;
                    cartProvider.item = cartItems;

                    calculateAmount();

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 95,
                        padding: const EdgeInsets.all(8.00),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 214, 209, 209),
                            borderRadius: BorderRadius.circular(5.00)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: double.infinity,
                                width: size * .2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.00),
                                    color: const Color.fromARGB(
                                        255, 236, 232, 232),
                                    image: DecorationImage(
                                        image: NetworkImage(data["image"]),
                                        fit: BoxFit.cover)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data["name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.8))),
                                  Text(
                                    data["price"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    data["variant"] != "null"
                                        ? "Size:  ${data["variant"]}"
                                        : "",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(4.00),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (data["quantity"] > 1) {
                                            FirebaseFirestore.instance
                                                .collection("user")
                                                .doc(user!.email)
                                                .collection("cart")
                                                .doc(data.id)
                                                .update({
                                              "quantity": data["quantity"] - 1,
                                            });

                                            setState(() {});
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection("user")
                                                .doc(user!.email)
                                                .collection("cart")
                                                .doc(data.id)
                                                .delete();

                                            setState(() {});
                                          }
                                        },
                                        child: data["quantity"] == 1
                                            ? const Icon(Icons.delete)
                                            : const Icon(Icons.remove)),
                                    Text(
                                      "${data["quantity"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("user")
                                              .doc(user!.email)
                                              .collection("cart")
                                              .doc(data.id)
                                              .update({
                                            "quantity": data["quantity"] + 1
                                          });
                                          setState(() {});
                                        },
                                        child: const Icon(Icons.add))
                                  ],
                                ),
                              )
                            ]),
                      ),
                    );
                  });
            }),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 150,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //----------------------Amount--------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                      Text(
                        totalAmount.toString(),
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                //------------------------------Button-----------------------------
                const CustomButton(
                  buttonName: "Buy Now",
                )
              ]),
        ));
  }
}
