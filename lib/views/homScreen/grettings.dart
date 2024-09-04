import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Grettings extends StatelessWidget {
  const Grettings({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = FirebaseAuth.instance.currentUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          userName!.displayName!,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Text(
          "Let's Start Shopping!",
          style: TextStyle(color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }
}
