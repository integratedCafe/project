import 'package:flutter/material.dart';
import 'package:intergrate_cafe/util/color.dart';

class Fnb extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Fnb({super.key, required this.currentIndex, required this.onTap});

  final List<Map<String, dynamic>> bottomItems = const [
    {'icon': Icons.home, 'label': '홈'},
    {'icon': Icons.local_cafe, 'label': '카페리스트'},
    {'icon': Icons.receipt_long, 'label': '주문내역'},
    {'icon': Icons.person, 'label': '마이페이지'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon']),
          label: item['label'],
        );
      }).toList(),
      currentIndex: currentIndex,
      selectedItemColor: ColorH.main(),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      showUnselectedLabels: true,
      enableFeedback: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
