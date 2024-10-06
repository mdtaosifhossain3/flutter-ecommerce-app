import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/product_card.dart';
import 'package:mini_ecommerce/views/productDetails/product_details_secreen.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Recent Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.00,
        ),
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                    baseColor: const Color(0xffe4e4e4),
                    highlightColor: Colors.grey.shade100,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: MediaQuery.of(context)
                                    .size
                                    .width /
                                (MediaQuery.of(context).size.height / 1.24)),
                        itemCount: 5,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: const Color(0xffefefef),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          );
                        }));
              } else {
                return LayoutBuilder(builder: (context, constraints) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (constraints.maxWidth < 600)
                            ? 2
                            : 3, // Responsive column count
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: (constraints.maxWidth < 600)
                            ? 0.64
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
                              price: data['price'],
                              rating: 1.5,
                            ));
                      });
                });
              }
            })
      ]),
    );
  }
}
