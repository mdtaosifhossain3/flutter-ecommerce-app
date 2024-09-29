import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppbar(
    {String? title,
    List<Widget>? action,
    Widget? isLeading,
    required BuildContext context,
    Color? bgColor}) {
  return AppBar(
    backgroundColor: bgColor,
    elevation: 3.00,
    centerTitle: true,
    leading: isLeading ??
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 20,
            )),
    title: title != null
        ? Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        : null,
    actions: action,
  );
}
