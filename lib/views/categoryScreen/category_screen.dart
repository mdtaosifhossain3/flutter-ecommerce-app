import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/product_card.dart';
import 'package:mini_ecommerce/views/productDetails/product_details_secreen.dart';

class CategoryScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;
  CategoryScreen({super.key, required this.category});

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: category['name']),
      body: StreamBuilder(
          stream: fireStore
              .collection('products')
              .where('cat_id', isEqualTo: category['id'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LayoutBuilder(builder: (context, constraints) {
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
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return GestureDetector(
                        onTap: () {
                          Get.to(ProductDetailsSecreen(
                            product: data,
                          ));
                        },
                        child: ProductCard(
                          photoURL: data['image'],
                          title: data['name'] ?? "Ttile",
                          price: "\$ 855",
                          rating: 1.5,
                        ));
                  });
            });
          }),
    );
  }
}
