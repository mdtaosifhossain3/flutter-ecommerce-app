import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/app_config.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/customScreen/custom_screen.dart';

import 'package:mini_ecommerce/views/homScreen/categories.dart';
import 'package:mini_ecommerce/views/homScreen/grettings.dart';
import 'package:mini_ecommerce/views/homScreen/product_screen.dart';
import 'package:mini_ecommerce/views/homScreen/slider.dart';
import 'package:mini_ecommerce/views/wishListScreen/wishlist_screen.dart';
import 'package:mini_ecommerce/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final userName = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerWidget(),
      appBar: AppBar(
          title: TextWidget(
            label: AppConfig.appName,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                  Get.to(WishlistScreen());
                },
                child: Image.asset(
                  "assets/icons/Bag.png",
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ]),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Grettings
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10),
              child: Grettings(),
            ),

            //Slider
            SliderWidget(),
            //categories
            Categories(),
            SizedBox(
              height: 15.00,
            ),
            //Products
            ProductScreen()
          ],
        ),
      ),
    );
  }
}
