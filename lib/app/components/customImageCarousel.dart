import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class CustomImageCarousel extends StatelessWidget {
  const CustomImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    const Color colorSelect= Color(0xFFEA1818);
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: colorSelect,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {
      },
      autoPlayInterval: 10000,
      isLoop: true,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'lib/assets/slider/images1.png',
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'lib/assets/slider/images2.png',
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'lib/assets/slider/slider4.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
