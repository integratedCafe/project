import 'package:flutter/material.dart';

class CafeListItem extends StatelessWidget {
  final String name;
  final String location;

  const CafeListItem({required this.name, required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트가 왼쪽으로 정렬되도록 설정
      children: [
        Container(
          height: 100, // 이미지의 고정된 높이
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Image.asset('images/home/c1.jpg', fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2, // 최대 2줄로 제한
            overflow: TextOverflow.ellipsis, // 텍스트가 넘치면 '...'으로 표시
          ),
        ),
        Flexible(
          // Flexible을 사용하여 location 텍스트가 길면 자동으로 줄바꿈
          child: Text(
            location,
            style: const TextStyle(color: Colors.grey),
            maxLines: 2, // 최대 2줄까지 표현 가능
            overflow: TextOverflow.ellipsis, // 텍스트가 넘치면 '...'으로 표시
          ),
        ),
      ],
    );
  }
}
