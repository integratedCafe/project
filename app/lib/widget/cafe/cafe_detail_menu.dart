import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Util
import 'package:intergrate_cafe/util/service.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

class CafeDetailMenu extends ConsumerStatefulWidget {
  final Map<String, dynamic> datas;

  const CafeDetailMenu({super.key, required this.datas});

  @override
  _CafeDetailMenuState createState() => _CafeDetailMenuState();
}

class _CafeDetailMenuState extends ConsumerState<CafeDetailMenu> {
  late List<Map<String, dynamic>> menuItems;

  @override
  void initState() {
    super.initState();
    final provider = ref.read(totalProvider);

    // 상태가 비어있으면 초기화, 그렇지 않으면 provider에서 데이터 사용
    if (provider['cafe'] == null) {
      menuItems = List<Map<String, dynamic>>.from(widget.datas['menus'] ?? [])
          .map((menu) => {
                ...menu,
                'qty': menu['qty'] ?? 0,
                'isAdd': menu['isAdd'] ?? false,
              })
          .toList();
    } else {
      menuItems =
          List<Map<String, dynamic>>.from(provider['cafe']['menus'] ?? [])
              .map((menu) => {
                    ...menu,
                    'qty': menu['qty'] ?? 0,
                    'isAdd': menu['isAdd'] ?? false,
                  })
              .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _cafeMenuItem(menuItems[index], index);
      },
    );
  }

  Widget _cafeMenuItem(Map<String, dynamic> data, int index) {
    final provider = ref.watch(totalProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _menuImage(),
          const SizedBox(width: 16),
          Expanded(child: _menuDetails(data, provider, index)),
        ],
      ),
    );
  }

  Widget _menuImage() {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: Image.asset(
        'images/cafe/temp_americano.jpg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _menuDetails(Map<String, dynamic> data, dynamic provider, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['description'] ?? 'No description',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          '${Service().formatComma(data['price'])}원',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        data['isAdd']
            ? _quantityControls(data, provider, index)
            : _addButton(data, provider),
      ],
    );
  }

  Widget _quantityControls(
      Map<String, dynamic> data, dynamic provider, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('수량', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (data['qty'] > 1) {
                    data['qty']--;

                    final updateMenu = List<Map<String, dynamic>>.from(
                            widget.datas['menus'])
                        .map((menu) => menu['_id'] == data['_id'] ? data : menu)
                        .toList();
                    provider.addItem({
                      ...widget.datas,
                      'menus': updateMenu,
                    });
                  }
                });
              },
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                data['qty'].toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  data['qty']++;

                  final updateMenu = List<Map<String, dynamic>>.from(
                          widget.datas['menus'])
                      .map((menu) => menu['_id'] == data['_id'] ? data : menu)
                      .toList();
                  provider.addItem({
                    ...widget.datas,
                    'menus': updateMenu,
                  });
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  data['isAdd'] = false;
                  data['qty'] = 1;
                });
                provider.removeItem(data['_id']);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _addButton(Map<String, dynamic> data, dynamic provider) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          data['isAdd'] = true;
          data['qty'] = 1;

          final updateMenu =
              List<Map<String, dynamic>>.from(widget.datas['menus'])
                  .map((menu) => menu['_id'] == data['_id'] ? data : menu)
                  .toList();
          provider.addItem({
            ...widget.datas,
            'menus': updateMenu,
          });
        });
      },
      child: const Text('담기'),
    );
  }
}
