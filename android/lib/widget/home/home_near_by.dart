import 'package:flutter/material.dart';

class HomeNearBy extends StatefulWidget {
  final List<Map<String, String>> nearByList;

  const HomeNearBy({super.key, required this.nearByList});

  @override
  _HomeNearBy createState() => _HomeNearBy();
}

class _HomeNearBy extends State<HomeNearBy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: widget.nearByList.map((nearByItem) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: nearByListItem(nearByItem),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget nearByListItem(Map<String, String> data) {
    return Row(
      children: [
        // Expanded로 감싸서 Row 안에서 AspectRatio가 크기를 받도록 함
        Expanded(
          flex: 2, // 이미지가 차지할 비율 설정
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 16 / 9, // 원하는 비율 설정 (16:9)
              child: Image.asset(
                data['image']!,
                fit: BoxFit.cover, // 비율에 맞게 이미지를 자르거나 축소
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 텍스트 영역도 확장 가능하게 설정
        Expanded(
          flex: 3, // 텍스트가 차지할 비율 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(data['take'] ?? '-'),
              const SizedBox(height: 2),
              Text(data['distance'] ?? '-'),
            ],
          ),
        ),
      ],
    );
  }
}
