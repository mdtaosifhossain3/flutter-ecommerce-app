import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_button.dart';
import 'package:mini_ecommerce/providers/cart_provider.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsSecreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  const ProductDetailsSecreen({super.key, required this.product});

  @override
  State<ProductDetailsSecreen> createState() => _ProductDetailsSecreenState();
}

class _ProductDetailsSecreenState extends State<ProductDetailsSecreen> {
  final List<String> productVariant = ['35', "38", '45', "48", "52", "58"];

  final user = FirebaseAuth.instance.currentUser;

  int selectedFieldIndex = 0;
  String? selectedVariant;

  void changeSelectedVariant() {
    setState(() {
      selectedVariant = widget.product["variants"].isEmpty
          ? "null"
          : widget.product["variants"][0];
    });
  }

  @override
  void initState() {
    changeSelectedVariant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppbar(context: context, bgColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xffd9d9d9),
              height: size.height * .4,
              width: double.infinity,
              child: Center(
                  child: Image.network(
                widget.product['image']!,
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product name
                  Text(
                    widget.product['name'] ?? "title",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product['price'] ?? "00",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Available in stock",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "About",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product["desc"]!,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),

                  const SizedBox(
                    height: 10.00,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product["variants"].length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFieldIndex = index;
                            selectedVariant = widget.product["variants"][index];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15.00),
                          width: 40,
                          decoration: BoxDecoration(
                              color: selectedFieldIndex == index
                                  ? AppColors.primaryColor
                                  : const Color(0xffd9d9d9),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                              child: Text(
                            widget.product["variants"][index],
                            style: TextStyle(
                                color: selectedFieldIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    }),
              ),
              CustomButton(
                btnName: "Register",
                textColor: Colors.white,
                bgColor: AppColors.primaryColor,
                onClick: () {
                  cartProvider.addProduct(widget.product, selectedVariant);
                },
              )
              // CustomButton(
              //     buttonName: "Add to Cart",
              //     onTap: () {
              //       cartProvider.addProduct(widget.product, selectedVariant);
              //     }, bgColor: null,)
            ]),
      ),
    );
  }
}
