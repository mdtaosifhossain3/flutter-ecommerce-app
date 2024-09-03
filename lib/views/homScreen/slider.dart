import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderScreen extends StatelessWidget {
  final List fireStoreSlides;
  const SliderScreen({super.key, required this.fireStoreSlides});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 15),
      height: 150,
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: fireStoreSlides.length,
          itemBuilder: (context, index, realIndex) {
            return fireStoreSlides.isEmpty
                ? Shimmer.fromColors(
                    baseColor: const Color(0xffe4e4e4),
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ))
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.00),
                        image: DecorationImage(
                            image:
                                NetworkImage(fireStoreSlides[index]['image']),
                            fit: BoxFit.cover)),
                  );
          },
          options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true)),
    );
  }
}
