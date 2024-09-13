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
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: CarouselSlider.builder(
              itemCount: widget.tabList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 150, // 원하는 최대 높이 설정
                          ),
                          child: Image.asset(
                            widget.tabList[index]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      _buildBottomInfo(widget.tabList[index]),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.34, // 슬라이더가 3개 보이도록 설정
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                padEnds: false, // 양쪽 끝에 여백을 제거
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomInfo(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
