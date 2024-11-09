import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CafeDetailImage extends StatefulWidget {
  final List<String> images;
  final String cafeName;

  const CafeDetailImage(
      {super.key, required this.images, required this.cafeName});

  @override
  _CafeDetailImage createState() => _CafeDetailImage();
}

class _CafeDetailImage extends State<CafeDetailImage> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          CarouselSlider(
            items: widget.images.map((path) {
              return Image.asset(
                path,
                fit: BoxFit.fill,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              enlargeCenterPage: false,
              aspectRatio: MediaQuery.of(context).size.width / 200,
              viewportFraction: 1.0,
            ),
          ),
          Positioned(
            bottom: 5.0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.cafeName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLike ? Icons.favorite : Icons.favorite_border,
                      color: isLike ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      print('좋아요 클릭');
                      setState(() {
                        isLike = !isLike;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
