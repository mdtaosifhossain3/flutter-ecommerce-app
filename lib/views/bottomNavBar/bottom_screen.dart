import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/cartScreen/cart_screen.dart';
import 'package:mini_ecommerce/views/personScreen/person.dart';
import 'package:mini_ecommerce/views/searchScreen/search_screen.dart';
import 'package:mini_ecommerce/views/homScreen/home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int currentIdx = 0;

  List<Widget> myScreens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIdx,
        onTap: (val) {
          setState(() {
            currentIdx = val;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              size: 26.00,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
        ],
      ),
      body: SafeArea(child: myScreens[currentIdx]),
    );
  }
}
