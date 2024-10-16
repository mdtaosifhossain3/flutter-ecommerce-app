import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/controllers/wishlist_controller.dart';
import 'package:mini_ecommerce/db/local/db_helper.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/product_card.dart';
import 'package:mini_ecommerce/views/productDetails/product_details_secreen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  WishlistController wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    wishlistController.allNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "WishList"),
      body: LayoutBuilder(builder: (context, constraints) {
        return Obx(() {
          print(wishlistController.allNotes.length);
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (constraints.maxWidth < 600)
                    ? 2
                    : 3, // Responsive column count
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: (constraints.maxWidth < 600)
                    ? 0.7
                    : 0.8, // Responsive aspect ratio
              ),
              itemCount: wishlistController.allNotes.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                final data = wishlistController.allNotes[index];

                return GestureDetector(
                    onTap: () async {
                      QuerySnapshot<Map<String, dynamic>> snapshot =
                          await FirebaseFirestore.instance
                              .collection('products')
                              .where('id', isEqualTo: int.parse(data["key"]))
                              .limit(1) // Limit to one document
                              .get();

                      // Retrieve the first document or null if none exists
                      QueryDocumentSnapshot<Map<String, dynamic>>? doc =
                          snapshot.docs.isNotEmpty ? snapshot.docs.first : null;

                      Get.to(ProductDetailsSecreen(
                        sNO: data['sNo'],
                        product: doc,
                      ));
                    },
                    child: ProductCard(
                      photoURL: data['image'],
                      title: data['title'] ?? "Ttile",
                      price: data['price'] ?? "00",
                      rating: data['rating'],
                    ));
              });
        });
      }),
    );
  }
}
