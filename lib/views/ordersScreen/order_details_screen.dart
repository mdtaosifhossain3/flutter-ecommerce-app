import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_ecommerce/global_widgets/custom_appbar.dart';
import 'package:mini_ecommerce/global_widgets/custom_button.dart';
import 'package:mini_ecommerce/global_widgets/text_widget.dart';
import 'package:mini_ecommerce/views/reviewScreen/review_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {super.key, required this.items, required this.paymentStatus});

  final List items;
  final String paymentStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Orders"),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: ListTile(
                  title: Text(
                    item['productName'],
                    maxLines: 2,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label: "Price: \$${item['price']}",
                        fontWeight: FontWeight.bold,
                      ),
                      TextWidget(
                        label: "Quantity:${item['quantity']} ",
                        fontSize: 16,
                      ),
                    ],
                  ),
                  trailing: CustomButton(
                    onClick: () => Get.to(const AddReviewPage()),
                    btnName: "Add Review",
                    width: .28,
                    verticalPadding: 14,
                  )),
            );
          }),
    );
  }
}

/** paymentStatus == "pending"
                    ? null
                    :  */