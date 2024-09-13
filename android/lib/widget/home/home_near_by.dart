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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '내 위치에 가까운 매장이예요',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Column(
                children: widget.nearByList.map((nearByItem) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: nearByListItem(nearByItem),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nearByListItem(Map<String, String> data) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                data['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
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
