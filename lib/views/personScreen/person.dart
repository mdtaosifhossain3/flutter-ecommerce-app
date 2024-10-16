import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_ecommerce/controllers/profile_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/authentication/loginScreen/login_screen.dart';
import 'package:mini_ecommerce/views/ordersScreen/order_details_screen.dart';
import 'package:mini_ecommerce/views/personScreen/address_card.dart';
import 'package:mini_ecommerce/views/personScreen/edit_info.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  ProfilePage({super.key});

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
                      backgroundImage: controller.photoURL.value.isNotEmpty
                          ? NetworkImage(controller.photoURL.value)
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
                    Get.to(const EditInfo());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Shipping Address'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to order details if needed
                    Get.to(AddressCard(
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

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("orders")
                        .where("userId", isEqualTo: user!.uid)
                        .orderBy("orderDate")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const TextWidget(
                          label: "No data found",
                          mainAxisAlignment: MainAxisAlignment.center,
                          fontSize: 15,
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: TextWidget(
                            label: "Something went wrong",
                            fontSize: 15,
                            color: AppColors.redColor,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs
                            .length, // Replace with actual order count
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          final items = data["items"];

                          return ListTile(
                            leading: const Icon(Icons.shopping_bag),
                            title: TextWidget(
                              label: 'Order# ${index + 1}',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            subtitle: TextWidget(
                              label: 'Status: ${data["paymentStatus"]}',
                              fontSize: 14,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Navigate to order details if needed
                              Get.to(OrderDetails(
                                items: items,
                                paymentStatus: data["paymentStatus"],
                              ));
                            },
                          );
                        },
                      );
                    })
                // Replace this with actual order data from your database
              ],
            ),
          )),
    );
  }
}
