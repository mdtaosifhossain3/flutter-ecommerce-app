import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/controllers/address_controller.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class AddressCard extends StatefulWidget {
  final VoidCallback onEdit; // Callback for the Edit button
  final VoidCallback onAdd; // Callback for the Add button
  final VoidCallback onDelete; // Callback for the Delete button

  const AddressCard({
    super.key,
    required this.onEdit,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  final user = FirebaseAuth.instance.currentUser!.email;
  AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Address"),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user")
                .doc(user!)
                .collection("address")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: TextWidget(
                    mainAxisAlignment: MainAxisAlignment.center,
                    label: "Please add an Address",
                    color: AppColors.greyColor,
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final userAddress = snapshot.data!.docs[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, // Shadow color
                            blurRadius: 10.0, // Blur radius
                            spreadRadius: 1.0, // Spread radius
                            offset: Offset(1.0, 1.0), // Offset of the shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display User Full Name
                                Text(
                                  userAddress["fullName"],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Display Address Line 1 and 2
                                Text(
                                  userAddress["addressLine1"],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                if (userAddress["addressLine2"]
                                    .isNotEmpty) // Check if Address Line 2 exists
                                  Text(
                                    userAddress["addressLine2"],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                const SizedBox(height: 4.0),

                                //  Display City, State, Postal Code
                                Text(
                                  '${userAddress["city"]}, ${userAddress["state"]} ${userAddress["postalCode"]}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),

                                // Display Country
                                Text(
                                  userAddress["country"],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Display Phone Number
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      userAddress["phoneNumber"],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),

                                // Show default badge if the address is default
                                if (userAddress["isDefault"])
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.green),
                                        SizedBox(width: 6.0),
                                        Text(
                                          'Default Address',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            // Add, Edit, and Delete buttons
                            Positioned(
                              right: 0,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: AppColors.greyColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: InkWell(
                                      onTap: () {
                                        _showAddressDialog(
                                            isEdit: true,
                                            userAddress: userAddress);
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: AppColors.whiteColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: AppColors.redColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: InkWell(
                                      onTap: () {
                                        addressController
                                            .deleteAddress(userAddress.id);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: AppColors.whiteColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddressDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddressDialog({bool isEdit = false, userAddress}) {
    Get.dialog(
      AlertDialog(
        title: Text(isEdit ? 'Edit Address' : "Add your Address"),
        content: Form(
          key: addressController.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                    'Address Line 1', addressController.addressLine1Controller,
                    userData: userAddress['addressLine1']),
                _buildTextField('Address Line 2 (Optional)',
                    addressController.addressLine2Controller,
                    required: false, userData: userAddress['addressLine2']),
                _buildTextField('City', addressController.cityController,
                    userData: userAddress['city']),
                _buildTextField('Country', addressController.countryController,
                    userData: userAddress['country']),
                _buildTextField(
                    'Full Name', addressController.fullNameController,
                    userData: userAddress['fullName']),
                _buildTextField(
                    'Phone Number', addressController.phoneNumberController,
                    userData: userAddress['phoneNumber']),
                _buildTextField(
                    'Postal Code', addressController.postalCodeController,
                    userData: userAddress['postalCode']),
                _buildTextField('State', addressController.stateController,
                    userData: userAddress['state']),
                Obx(() => CheckboxListTile(
                      title: const Text('Set as Default'),
                      value: addressController.isDefault.value,
                      onChanged: (value) {
                        addressController.isDefault.value = value!;
                      },
                    )),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              isEdit
                  ? addressController.editForm(userAddress.id)
                  : addressController.submitForm(); // Call controller method
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool required = true, userData}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller..text = userData ?? "",
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            return '$label cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
