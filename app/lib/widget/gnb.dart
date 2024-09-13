import 'package:flutter/material.dart';
import 'package:intergrate_cafe/util/color.dart';

class Gnb extends StatefulWidget {
  final VoidCallback onNavigateHome;

  const Gnb({super.key, required this.onNavigateHome});

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
            onTap: widget.onNavigateHome,
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
        ],
      ),
    );
  }
}
