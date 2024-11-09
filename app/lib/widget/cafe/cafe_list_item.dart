import 'package:flutter/material.dart';

class CafeListItem extends StatelessWidget {
  final String name;
  final String location;

  const CafeListItem({required this.name, required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Image.asset(
              'images/home/c1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          location,
          style: const TextStyle(color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
