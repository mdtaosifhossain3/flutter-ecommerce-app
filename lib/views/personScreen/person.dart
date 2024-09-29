import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_ecommerce/controllers/profile_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/models/address_model.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/personScreen/address_card.dart';
import 'package:mini_ecommerce/views/personScreen/edit_info.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          isLeading: const SizedBox.shrink(),
          title: "Porfile",
          action: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(const LoginScreen());
                },
                icon: const Icon(Icons.logout))
          ]),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: controller.updateProfileImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.imageUrl.value.isNotEmpty
                          ? NetworkImage(controller.imageUrl.value)
                          : const AssetImage('assets/images/default_user.png')
                              as ImageProvider,
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child:
                            Icon(Icons.camera_alt, color: AppColors.greyColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    controller.displayName.value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    controller.user?.email ?? 'No Email',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to order details if needed
                    Get.to(EditInfo());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Shipping Address'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to order details if needed
                    Get.to(AddressCard(
                      address: Address(
                          id: "1",
                          userId: "18456454",
                          fullName: "fullName",
                          addressLine1: "addressLine1",
                          city: "city",
                          state: "state",
                          postalCode: "postalCode",
                          country: "country",
                          phoneNumber: "phoneNumber"),
                      onEdit: () {},
                      onAdd: () {},
                      onDelete: () {},
                    ));
                  },
                ),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  'Orders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Replace this with actual order data from your database
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3, // Replace with actual order count
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: Text('Order #${index + 1}'),
                      subtitle: const Text('Status: Delivered'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to order details if needed
                      },
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? initialValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller..text = initialValue ?? '',
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
