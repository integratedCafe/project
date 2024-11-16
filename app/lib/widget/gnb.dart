import 'package:flutter/material.dart';
import 'package:intergrate_cafe/util/color.dart';

class Gnb extends StatefulWidget {
  final VoidCallback onNavigate;
  final String currentPage;
  const Gnb({super.key, required this.onNavigate,  required this.currentPage});

  @override
  _GnbState createState() => _GnbState();
}

class _GnbState extends State<Gnb> {
  void _onBellPressed() {
    print('Bell Icon 클릭됨');
  }

  void _onCartPressed() {
    print('장바구니 아이콘 클릭됨');
  }

  void _onSettingPressed() {
    print('장바구니 아이콘 클릭됨');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorH.main(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: widget.onNavigate,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'ICafe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
          if (widget.currentPage == 'home')
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications,
                    size: 24, color: Colors.white),
                onPressed: _onBellPressed,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart,
                    size: 24, color: Colors.white),
                onPressed: _onCartPressed,
              ),
            ],
          ),
          if (widget.currentPage == 'myPage')
            IconButton(
              icon: const Icon(Icons.settings,
                  size: 24, color: Colors.white),
              onPressed: _onCartPressed,
            ),

        ],
      ),
    );
  }
}
