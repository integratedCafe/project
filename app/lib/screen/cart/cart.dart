import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intergrate_cafe/provider/cafe/total.dart';

// Screen
import 'package:intergrate_cafe/screen/cart/payment.dart';

// Util
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/service.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TotalProvider의 state를 구독
    final state = ref.watch(totalProvider);

    // state에서 'cafe' 키의 데이터를 가져옴
    final cafe = state['cafe'] ?? {};
    final menus = cafe['menus'] ?? [];
    print('cart menus >>>>> $menus');
    // qty > 0인 메뉴 필터링
    final filteredMenus = List<Map<String, dynamic>>.from(menus)
        .where((menu) => (menu['qty'] != null))
        .toList();

    // 총 금액 계산
    final totalPrice = Service().formatComma(
      filteredMenus.fold<int>(
        0,
        (int total, dynamic item) {
          if (item['qty'] != null) {
            final price = (item['price'] as num?)?.toInt() ?? 0;
            final qty = (item['qty'] as num?)?.toInt() ?? 0;

            return total + (price * qty);
          }

          return total;
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('장바구니'),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: filteredMenus.isEmpty
                ? const Center(
                    child: Text('장바구니가 비어 있습니다.'),
                  )
                : ListView.builder(
                    itemCount: filteredMenus.length,
                    itemBuilder: (context, index) {
                      final item = filteredMenus[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                          child:
                              Center(child: Text(item['image'] ?? 'No Image')),
                        ),
                        title: Text(item['description'] ?? 'No Description'),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                final menu = state['cafe']?['menus']?[index];
                                // 수량 감소 로직
                                if (item['qty'] > 1) {
                                  final updateMenu =
                                      List<Map<String, dynamic>>.from(
                                              state['cafe']['menus'])
                                          .map((item) {
                                    if (item['_id'] == menu['_id']) {
                                      return {
                                        ...item,
                                        'qty': (item['qty'] ?? 1) - 1,
                                      };
                                    }
                                    return item;
                                  }).toList();

                                  ref.read(totalProvider.notifier).addItem({
                                    ...state['cafe'],
                                    'menus': updateMenu,
                                  });
                                }
                              },
                            ),
                            Text('${item['qty']}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                final menu = state['cafe']?['menus']?[index];
                                // 수량 증가 로직
                                final updateMenu =
                                    List<Map<String, dynamic>>.from(
                                            state['cafe']['menus'])
                                        .map((item) {
                                  if (item['_id'] == menu['_id']) {
                                    return {
                                      ...item,
                                      'qty': (item['qty'] ?? 1) + 1,
                                    };
                                  }
                                  return item;
                                }).toList();

                                ref.read(totalProvider.notifier).addItem({
                                  ...state['cafe'],
                                  'menus': updateMenu,
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.all(16),
            color: ColorH.main(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorH.main(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Payment()),
                    );
                  },
                  child: Text(
                    '총 $totalPrice원 주문하기',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
