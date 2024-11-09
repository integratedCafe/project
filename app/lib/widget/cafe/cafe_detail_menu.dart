import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Util
import 'package:intergrate_cafe/util/service.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

class CafeDetailMenu extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> datas;
  const CafeDetailMenu({super.key, required this.datas});

  @override
  _CafeDetailMenuState createState() => _CafeDetailMenuState();
}

class _CafeDetailMenuState extends ConsumerState<CafeDetailMenu> {
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.datas.length; i++) {
      widget.datas[i]['qty'] = widget.datas[i]['qty'] ?? 1;
      widget.datas[i]['isAdd'] = widget.datas[i]['isAdd'] ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.datas.length,
      itemBuilder: (context, index) {
        return _cafeMenuItem(widget.datas[index], index);
      },
    );
  }

  Widget _cafeMenuItem(Map<String, dynamic> data, int index) {
    final provider = ref.watch(totalProvider.notifier);

    bool isAdd = data['isAdd'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child:
                Image.asset('images/cafe/temp_americano.jpg', fit: BoxFit.fill),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    data['description'] ?? 'No description',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  child: Text(
                    '${Service().formatComma(data['price'])}원',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                isAdd
                    ? Row(
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
                                      data['qty'] = data['qty'] - 1;
                                    }
                                  });
                                  provider.addItem({...data});
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
                                    data['qty'] = data['qty'] + 1;
                                  });
                                  provider.addItem({...data});

                                  print('provider >>>> ${provider.state}');
                                },
                              ),
                              Align(
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    setState(() {
                                      data['isAdd'] = false;
                                      data['qty'] = 1;
                                    });
                                    provider.removeItem(data['_id']);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            data['isAdd'] = true;
                          });
                          provider.addItem({...data});
                        },
                        child: const Text('담기'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
