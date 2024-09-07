import 'package:flutter/material.dart';
import 'package:mini_ecommerce/global_widgets/custom_textfield.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/app_config.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: AppColors.whiteColor,
      shadowColor: AppColors.greyColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            AppConfig.appName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                leading: const CircleAvatar(
                  radius: 25,
                ),
                title: const TextWidget(label: "Muhammad Taosif"),
                subtitle: const TextWidget(
                  label: "muhammad@gmail.com",
                  color: AppColors.greyColor,
                  fontSize: 12,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "Password",
                    icon: "assets/icons/Lock.png",
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "Orders",
                    icon: "assets/icons/Heart.png",
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "My Cards",
                    icon: "assets/icons/Bag.png",
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "Wishlist",
                    icon: "assets/icons/Wallet.png",
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "Settings",
                    icon: "assets/icons/Setting.png",
                    fontSize: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.00),
                  child: TextWidget(
                    label: "Account Information",
                    icon: "assets/icons/Info.png",
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {},
              child: const TextWidget(
                label: "Log Out",
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ))
        ],
      ),
    );
  }
}
