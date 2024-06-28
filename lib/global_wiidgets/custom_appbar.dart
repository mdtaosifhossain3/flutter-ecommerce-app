import 'package:flutter/material.dart';

PreferredSizeWidget customAppbar(
    {String? title,
    List<Widget>? action,
    Widget? isLeadin,
    required BuildContext context,
    Color? bgColor}) {
  return AppBar(
    backgroundColor: bgColor,
    elevation: 3.00,
    centerTitle: true,
    leading: isLeadin ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
    title: title != null
        ? Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        : null,
    actions: action,
  );
}
