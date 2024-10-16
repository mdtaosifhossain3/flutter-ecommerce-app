import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/controllers/cart_controller.dart';
import 'package:mini_ecommerce/controllers/wishlist_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/cartScreen/cart_screen.dart';
import 'package:mini_ecommerce/views/reviewScreen/review_screen.dart';
import 'package:mini_ecommerce/widgets/review_widget.dart';

class ProductDetailsSecreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? product;
  final String? sNO;
  const ProductDetailsSecreen({super.key, this.product, this.sNO});

  @override
  State<ProductDetailsSecreen> createState() => _ProductDetailsSecreenState();
}

class _ProductDetailsSecreenState extends State<ProductDetailsSecreen> {
  final List<String> productVariant = ['35', "38", '45', "48", "52", "58"];
  CartController cartController = Get.put(CartController());
  WishlistController wishlistController =
      Get.put(WishlistController(), permanent: true);

  final user = FirebaseAuth.instance.currentUser;

  int selectedFieldIndex = 0;
  String? selectedVariant;
  bool isExpanded = false;

  void changeSelectedVariant() {
    setState(() {
      selectedVariant = widget.product!["variants"].isEmpty
          ? "null"
          : widget.product!["variants"][0];
    });
  }

  @override
  void initState() {
    changeSelectedVariant();

    print(
        "The Bool ${wishlistController.isFound(widget.product!["id"].toString())}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppbar(context: context, title: "Product Info"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: size.height * .35,
                  child: Center(
                    child: Image.network(
                      width: double.infinity,
                      fit: BoxFit.contain,
                      widget.product!['image'],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 5.00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name
                    Text(
                      widget.product!['name'] ?? "title",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < 1.5 ? Icons.star : Icons.star_border,
                              color: Colors.yellow, // Yellow for rating stars
                              size: 25.0,
                            ),
                          ),
                        ),
                        Obx(() {
                          return IconButton(
                              onPressed: () async {
                                wishlistController.isAdded.toggle();

                                final String sNo =
                                    wishlistController.allNotes.isNotEmpty
                                        ? wishlistController
                                            .allNotes
                                            .last[wishlistController
                                                .dbRef?.COLUMN_CARD_SNO]
                                            .toString()
                                        : "";

                                wishlistController.isFound(
                                        widget.product!["id"].toString())
                                    ? await wishlistController
                                        .removedFromWishList(
                                            key: widget.product!["id"]
                                                .toString())
                                    : await wishlistController.wishlist(
                                        title: widget.product!['name'],
                                        price: widget.product!['price'],
                                        rating: 1.5,
                                        image: widget.product!['image'],
                                        key: widget.product!["id"].toString());
                              },
                              icon: Icon(wishlistController
                                      .isFound(widget.product!["id"].toString())
                                  ? Icons.favorite
                                  : Icons.favorite_outline));
                        })
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product!['price'] ?? "00",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Available in stock",
                          style: TextStyle(
                            color: AppColors.greyColor,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "About",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: AnimatedCrossFade(
                        firstChild: Text(
                          widget.product!["desc"],
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.greyColor),
                        ),
                        secondChild: Text(
                          widget.product!["desc"]!,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.greyColor),
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.to(const AddReviewPage());
                            },
                            child: const TextWidget(
                              label: "Add Review",
                            ))
                      ],
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ReviewWidget(
                            photoURL: 'https://via.placeholder.com/150',
                            userName: 'John Doe',
                            rating: 4.5,
                            reviewTime: '2 days ago',
                            description:
                                'This is a very detailed review of the product. It has more content when expanded.expandedexpandedexpandedexpandedexpanded',
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 150,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.product!["variants"].isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.product!["variants"].length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedFieldIndex = index;
                                  selectedVariant =
                                      widget.product!["variants"][index];
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
                                  widget.product!["variants"][index],
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  btnName: "Add to Cart",
                  width: 1,
                  onClick: () {
                    cartController.addProduct(widget.product, selectedVariant);
                    Get.to(const CartScreen());
                  },
                ),
              )
            ]),
      ),
    );
  }
}
