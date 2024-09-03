import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';
import 'package:mini_ecommerce/utils/app_config.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/homScreen/categories.dart';
import 'package:mini_ecommerce/views/homScreen/grettings.dart';
import 'package:mini_ecommerce/views/homScreen/product_screen.dart';
import 'package:mini_ecommerce/views/homScreen/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final userName = FirebaseAuth.instance.currentUser;

  // List<Map<String, String>> products = [
  //   {
  //     "id": "1",
  //     "cat_id": "2",
  //     'image':
  //         "https://e7.pngegg.com/pngimages/204/549/png-clipart-apple-watch-smartwatch-wearable-technology-apple-products-electronics-gadget.png",
  //     'name': "Redmi Watch 5",
  //     'price': "\$45,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   },
  //   {
  //     "id": "2",
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiqWBYrsXCe8GT7Cm4294C6vpCS6XEVp4gtQ&usqp=CAU",
  //     'name': "Apple Watch 5",
  //     'price': "\$59,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   },
  //   {
  //     "id": "3",
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8r9JJpv-y381O76MUehx5w8rbrM9rTUuYHg&usqp=CAU",
  //     'name': "Note Watch 5",
  //     'price': "\$29,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   },
  //   {
  //     "id": "4",
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwIJOSvSUdva4ZEienNPICviugsxESML0MsQ&usqp=CAU",
  //     'name': "Pixl Watch 7",
  //     'price': "\$13,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   },
  //   {
  //     "id": "5",
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0jx0q1MfwzXoqN-BfhM5sKfIb0s6D0lTSWw&usqp=CAU",
  //     'name': "Rix Series-5",
  //     'price': "\$27,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   },
  //   {
  //     "id": "6",
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSirGprtDKUhfAnkj5Xu-AlcFF7Duw3NkrH_hw3nRqdl3mROWaKthe3wfEdQ-vTgIfYiQ4&usqp=CAU",
  //     'name': "Pik Flexe",
  //     'price': "\$19,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
  //   }
  // ];

  // List<Map<String, dynamic>> productsData = [
  //   {
  //     "id": 1,
  //     "cat_id": "2",
  //     'image':
  //         "https://e7.pngegg.com/pngimages/204/549/png-clipart-apple-watch-smartwatch-wearable-technology-apple-products-electronics-gadget.png",
  //     'name': "Redmi Watch 5",
  //     'price': "45,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
  //     "variants": ["35", "38", "42", "44", "48"]
  //   },
  //   {
  //     "id": 2,
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiqWBYrsXCe8GT7Cm4294C6vpCS6XEVp4gtQ&usqp=CAU",
  //     'name': "Apple Watch 5",
  //     'price': "59,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
  //     "variants": ["35", "38", "42", "44", "48"]
  //   },
  //   {
  //     "id": 3,
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8r9JJpv-y381O76MUehx5w8rbrM9rTUuYHg&usqp=CAU",
  //     'name': "Note Watch 5",
  //     'price': "29,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
  //     "variants": ["35", "38", "42", "44", "48"]
  //   },
  //   {
  //     "id": 4,
  //     "cat_id": "2",
  //     'image':
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwIJOSvSUdva4ZEienNPICviugsxESML0MsQ&usqp=CAU",
  //     'name': "Pixl Watch 7",
  //     'price': "13,000",
  //     "desc":
  //         "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
  //     "variants": ["35", "38", "42", "44", "48"]
  //   },
  // ];

  List fireStoreSlides = [];
  List userDeails = [];

  // Future addProducts() async {
  //   for (var item in productsData) {
  //     FirebaseFirestore.instance.collection("products").add(item);
  //   }
  //   // FirebaseFirestore.instance.collection("products").add(item);
  // }

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("banners").get();

    setState(() {
      fireStoreSlides.addAll(querySnapshot.docs);
    });
  }

  @override
  void initState() {
    //addProducts();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(
          bgColor: Colors.white,
          context: context,
          title: AppConfig.appName,
          isLeadin: const Icon(Icons.menu),
          action: [
            IconButton(
                padding: const EdgeInsets.only(right: 10.00),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) {
                    return const LoginScreen();
                  }), (route) => false);
                },
                icon: const Icon(Icons.logout))
          ]),
      body: Padding(
          padding:
              const EdgeInsets.only(bottom: 15.00, left: 10.00, right: 10.00),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Grettings
                const Grettings(),
                //slider
                SliderScreen(
                  fireStoreSlides: fireStoreSlides,
                ),
                //categories
                const Categories(),
                //Products
                const ProductScreen()
              ],
            ),
          )),
    );
  }
}
