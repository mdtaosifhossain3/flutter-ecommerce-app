import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/models/address_model.dart';
import 'package:mini_ecommerce/utils/colors.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onEdit; // Callback for the Edit button
  final VoidCallback onAdd; // Callback for the Add button
  final VoidCallback onDelete; // Callback for the Delete button

  const AddressCard({
    Key? key,
    required this.address,
    required this.onEdit,
    required this.onAdd,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Address"),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * .26,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
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
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display User Full Name
                    Text(
                      address.fullName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Display Address Line 1 and 2
                    Text(
                      address.addressLine1,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),
                    if (address.addressLine2
                        .isNotEmpty) // Check if Address Line 2 exists
                      Text(
                        address.addressLine2,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        ),
                      ),
                    const SizedBox(height: 4.0),

                    // Display City, State, Postal Code
                    Text(
                      '${address.city}, ${address.state} ${address.postalCode}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                      ),
                    ),

                    // Display Country
                    Text(
                      address.country,
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
                          address.phoneNumber,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    // Show default badge if the address is default
                    if (address.isDefault)
                      const Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green),
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

                // const SizedBox(height: 16.0),

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
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                      // Edit Button
                      // IconButton(
                      //     onPressed: () {}, icon: const Icon(Icons.edit)),
                      // ElevatedButton.icon(
                      //   onPressed: onEdit,
                      //   icon: const Icon(Icons.edit),
                      //   label: const Text('Edit'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.orangeAccent,
                      //   ),
                      // ),

                      // Delete Button
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.delete)),
                      // ElevatedButton.icon(
                      //   onPressed: onDelete,
                      //   icon: const Icon(Icons.delete),
                      //   label: const Text('Delete'),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.redAccent,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
