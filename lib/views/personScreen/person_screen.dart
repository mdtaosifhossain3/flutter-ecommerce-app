import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_row.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(user);
    return Scaffold(
      appBar: customAppbar(context: context, action: [
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
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.08),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0), //(x,y)
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      height: size.height * .42,
                      width: size.width * .94,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * .06,
                            ),
                            CustomRow(
                              title: "Name: ",
                              value: user!.displayName!,
                            ),
                            const Divider(),
                            CustomRow(
                              title: "Email: ",
                              value: user!.email!,
                            ),
                            const Divider(),
                            CustomRow(
                              title: "Phone: ",
                              value: user!.phoneNumber ?? "",
                            ),
                            const Divider(),
                            CustomRow(
                              title: "Orders: ",
                              value: "5",
                            ),
                            const Divider(),
                            CustomRow(
                              title: "Add to Cart: ",
                              value: "5",
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/p.png"),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
