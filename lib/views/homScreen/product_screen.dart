import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/views/productDetails/product_details_secreen.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Column(
        children: [
          SizedBox(
            height: 15.00,
          ),
          Text(
            "Recent Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.00,
          ),
        ],
      ),
      StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
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
                          childAspectRatio: MediaQuery.of(context).size.width /
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
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.24)),
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ProductDetailsSecreen(
                            product: data,
                          );
                        }));
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              //color: const Color(0xffefefef),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(15),
                                        topEnd: Radius.circular(15)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/p.png",
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.00, left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'] ?? "Ttile",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      data['price']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          })
    ]);
  }
}
