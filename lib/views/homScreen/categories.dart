import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:mini_ecommerce/views/categoryScreen/category_screen.dart';
import 'package:shimmer/shimmer.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Top Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "See All",
                style: TextStyle(color: AppColors.primaryColor),
              ))
        ],
      ),
      SizedBox(
        height: 64,
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xffe4e4e4),
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          color: const Color(0xffefefef),
                          margin: const EdgeInsets.only(right: 10.00),
                          width: 64,
                          height: 64,
                        );
                      }),
                );
              } else {
                return SizedBox(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return CategoryScreen(
                                category: snapshot.data!.docs[index],
                              );
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.00),
                            width: 64,
                            padding: const EdgeInsets.all(8.00),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xfff2f2f2),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(.5),
                                    width: 2.00)),
                            child: Image.network(
                              snapshot.data!.docs[index]['icon']!,
                            ),
                          ),
                        );
                      }),
                );
              }
            }),
      ),
    ]);
  }
}
