import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Screen
import 'package:intergrate_cafe/screen/cart/cart.dart';

// Util
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/service.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

class CafeDetailTotal extends ConsumerStatefulWidget {
  final Map<String, dynamic> cafe;

  const CafeDetailTotal({super.key, required this.cafe});

  @override
  _CafeDetailTotal createState() => _CafeDetailTotal();
}

class _CafeDetailTotal extends ConsumerState<CafeDetailTotal> {
  @override
  void initState() {
    super.initState();

    print('widget cafe >>>> ${widget.cafe}');
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(totalProvider);
    print('provider >>>> $provider');

    int total = 0;
    if (provider['cafe'] != null && provider['cafe']['menus'] != null) {
      total = (provider['cafe']['menus'] as List).fold<int>(
        0,
        (sum, item) {
          // isAdd가 true인 항목만 계산에 포함
          if (item['isAdd'] == true && item['qty'] != null) {
            final price = (item['price'] as num?)?.toInt() ?? 0;
            final qty = (item['qty'] as num?)?.toInt() ?? 0;
            return sum + (price * qty);
          }
          return sum;
        },
      );
    }

    // 포맷팅된 문자열로 변환
    String formattedTotal = Service().formatComma(total);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Cart()),
        );
        // provider = null;
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: ColorH.main(),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          '$formattedTotal원 담기',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
