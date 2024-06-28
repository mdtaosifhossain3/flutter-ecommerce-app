import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/global_wiidgets/custom_appbar.dart';

class CategoryScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;
  CategoryScreen({Key? key, required this.category}) : super(key: key);

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: category['name']),
      body: StreamBuilder(
          stream: fireStore
              .collection('products')
              .where('cat_id', isEqualTo: category['id'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['price']),
                    ),
                  );
                });
          }),
    );
  }
}
