import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plastic_bay/theme/app_color.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLink;
  const CarouselImage({super.key, required this.imageLink});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CarouselSlider(
                items: widget.imageLink
                    .map((link) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            //border: Border.all(color: AppColors.secondaryColor),
                            image: DecorationImage(
                              image: NetworkImage(link),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: const EdgeInsets.all(
                            10,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    })),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLink.asMap().entries.map((e) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor
                          .withOpacity(_currentIndex == e.key ? 0.9 : 0.4)),
                );
              }).toList(),
            )
          ],
        )
      ],
    );
  }
}
