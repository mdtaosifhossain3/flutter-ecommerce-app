import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidget();
}

class _SliderWidget extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("banners").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Shimmer.fromColors(
                  baseColor: const Color(0xffe4e4e4),
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    color: AppColors.whiteColor,
                    height: 130,
                  )),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Shimmer.fromColors(
                  baseColor: const Color(0xffe4e4e4),
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    color: AppColors.whiteColor,
                    height: 130,
                  )),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              height: 150,
              width: double.infinity,
              child: CarouselSlider.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.00),
                          image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data!.docs[index]['image']),
                              fit: BoxFit.cover)),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true)),
            );
          }
        });
  }
}
