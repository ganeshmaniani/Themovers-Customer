import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_url.dart';
import '../../../../feature.dart';

class CustomImageSlider extends ConsumerStatefulWidget {
  const CustomImageSlider({super.key});

  @override
  ConsumerState<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends ConsumerState<CustomImageSlider> {
  List<CustomerSlideImages> sliderImage = [];
  bool isLoading = false;
  String path = '';
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    initialImageSlider();
    super.initState();
  }

  initialImageSlider() {
    setState(() => isLoading = true);
    ref
        .read(imageSliderProvider.notifier)
        .getImageSlider()
        .then((res) => res.fold(
            (l) => {
                  setState(() => {
                        sliderImage = [],
                        path = '',
                        isLoading = false,
                      })
                },
            (r) => {
                  setState(() => {
                        sliderImage = r.customerSlideImages ?? [],
                        path = r.path ?? '',
                        isLoading = false,
                      })
                }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            log(currentIndex.toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CarouselSlider(
              items: sliderImage
                  .map((image) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.network(
                          ApiUrl.baseUrl + path + image.file.toString(),
                          fit: BoxFit.fitWidth,
                        ),
                      ))
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  aspectRatio: 16 / 8,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index + 1;
                    });
                  }),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliderImage.map((entry) {
                return InkWell(
                  onTap: () =>
                      carouselController.animateToPage(int.parse(entry.name!)),
                  child: Container(
                      width: currentIndex == int.parse(entry.name!) ? 17 : 7,
                      height: 7.h,
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: currentIndex == int.parse(entry.name!)
                              ? Colors.red
                              : Colors.grey)),
                );
              }).toList(),
            ))
      ],
    );
  }
}

/*
 Container(
  height: 500,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    borderRadius: Dimensions.kBorderRadiusAllSmall,
    image: DecorationImage(
      image: NetworkImage(
          ApiUrl.baseUrl + path + image.file.toString()),
      fit: BoxFit.cover,
    ),
  ),
)
 */
