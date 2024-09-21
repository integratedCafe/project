import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intergrate_cafe/util/color.dart';

class HomeMy extends StatefulWidget {
  final List<Map<String, String>> tabList;
  final String type;

  const HomeMy({super.key, required this.tabList, required this.type});

  @override
  _HomeMyState createState() => _HomeMyState();
}

class _HomeMyState extends State<HomeMy> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SizedBox(
            height: 250,
            child: CarouselSlider.builder(
              itemCount: widget.tabList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: double.maxFinite,
                      constraints: const BoxConstraints(
                        minHeight: 100.0,
                        maxHeight: 200,
                      ),
                      child: Image.asset(
                        widget.tabList[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: _buildBottomInfo(widget.tabList[index]),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 250.0,
                viewportFraction: 0.34,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                padEnds: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomInfo(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['name'] ?? '',
            style: TextStyle(color: ColorH.defaultText(), fontSize: 12),
            textAlign: TextAlign.left,
          ),
          Text(
            widget.type == 'frequency'
                ? data['distance'] ?? ''
                : data['option'] ?? '',
            style: TextStyle(color: ColorH.defaultText(), fontSize: 10),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
