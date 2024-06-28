import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final title;

  final value;
  CustomRow({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
