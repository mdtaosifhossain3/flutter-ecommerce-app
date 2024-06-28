import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/providers/cart_provider.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/bottomNavBar/bottom_screen.dart';
import 'package:mini_ecommerce/views/personScreen/person_screen.dart';
import 'package:mini_ecommerce/views/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CartProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
