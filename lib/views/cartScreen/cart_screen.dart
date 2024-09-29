import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/controllers/cart_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/orderConfirmedScreen/order_confirmed_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final user = FirebaseAuth.instance.currentUser;

  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (cartController.cartItems.isEmpty) {
            return const Center(
                child: TextWidget(
              mainAxisAlignment: MainAxisAlignment.center,
              label: 'No items in cart',
              color: AppColors.greyColor,
              fontSize: 15,
            ));
          }
          return ListView.builder(
              itemCount: cartController.cartItems.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = cartController.cartItems[index];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 95,
                    padding: const EdgeInsets.all(8.00),
                    decoration: BoxDecoration(
                        color: AppColors.categoryBoxColor,
                        borderRadius: BorderRadius.circular(5.00)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: double.infinity,
                            width: size * .2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.00),
                                color: AppColors.whiteColor,
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
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.8))),
                              Text(
                                data["price"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data["variant"] != "null"
                                    ? "Size:  ${data["variant"]}"
                                    : "",
                                style: const TextStyle(
                                    fontSize: 14, color: AppColors.greyColor),
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
                                      cartController.decreaseQuantity(data);
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
                                      cartController.increaseQuantity(data);
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
                      Obx(() {
                        return Text(
                          cartController.totalAmount.value.toString(),
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                ),

                //------------------------------Button-----------------------------

                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomButton(
                      btnName: "Buy Now",
                      onClick: cartController.cartItems.isEmpty
                          ? () {
                              print(cartController.cartItems.isEmpty);
                              print(cartController.cartItems.length);
                              Get.snackbar("", "Please add product first");
                              return;
                            }
                          : () {
                              Get.offAll(OrderConfirmedScreen());
                              return;
                            },
                      width: 1,
                    ),
                  );
                })
              ]),
        ));
  }
}
