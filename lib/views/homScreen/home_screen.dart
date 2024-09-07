import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/app_config.dart';

import 'package:mini_ecommerce/views/homScreen/categories.dart';
import 'package:mini_ecommerce/views/homScreen/grettings.dart';
import 'package:mini_ecommerce/views/homScreen/product_screen.dart';
import 'package:mini_ecommerce/views/homScreen/slider.dart';

import 'package:mini_ecommerce/views/welcomeScreen/welcome_screen.dart';
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
          ),
          centerTitle: true,
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 10.00),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.to(const WelcomeScreen());
                },
                icon: const Icon(Icons.logout))
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
