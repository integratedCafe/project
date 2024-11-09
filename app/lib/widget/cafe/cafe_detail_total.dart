import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Util
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/service.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

class CafeDetailTotal extends ConsumerStatefulWidget {
  const CafeDetailTotal({super.key});

  @override
  _CafeDetailTotal createState() => _CafeDetailTotal();
}

class _CafeDetailTotal extends ConsumerState<CafeDetailTotal> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(totalProvider);
    String total = Service().formatComma(provider.fold(
        0, (total, item) => (total + (item['price'] * item['qty'])).toInt()));

    return GestureDetector(
      onTap: () {
        print('$total원 담기 Add Button Click!');
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
          '$total원 담기',
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
