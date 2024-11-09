import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// API
import 'package:intergrate_cafe/util/api.dart';

// Widget
import 'package:intergrate_cafe/widget/cafe/cafe_detail_image.dart';
import 'package:intergrate_cafe/widget/cafe/cafe_detail_menu.dart';
import 'package:intergrate_cafe/widget/cafe/cafe_detail_total.dart';

// Provider
import 'package:intergrate_cafe/provider/cafe/total.dart';

final cafeImages = {
  'images': [
    'images/home/c1.jpg',
    'images/home/c2.jpg',
    'images/home/c3.jpg',
  ]
};

class CafeDetail extends ConsumerStatefulWidget {
  final String name;
  final String id;

  const CafeDetail({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  _CafeDetailState createState() => _CafeDetailState();
}

class _CafeDetailState extends ConsumerState<CafeDetail>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> cafeData = {};
  bool isLoading = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _getCafeDetail();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getCafeDetail() async {
    try {
      final res = await ApiService().get('/cafe/${widget.id}');
      print('API Response: $res');

      if (res['success']) {
        setState(() {
          cafeData = {
            'menus':
                List<Map<String, dynamic>>.from(res['cafe']['menus'] ?? []),
            'images': cafeImages['images'],
          };
        });

        print("Cafe Detail >>>>> $cafeData");
      } else {
        print('API Response >>>>> ${res['message']}');
      }
    } catch (e) {
      print("Error Cafe Detail API Error >>>> $e");
    } finally {
      setState(() {
        isLoading = false;
      });
      print('Final Cafe Data >>>>>> $cafeData');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(totalProvider);
    bool isTotalWidgetShow = provider.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cafeData.isEmpty
              ? const Center(child: Text('카페 정보를 불러올 수 없습니다.'))
              : Stack(
                  children: [
                    Column(
                      children: [
                        CafeDetailImage(
                          images: List<String>.from(cafeData['images'] ?? []),
                          cafeName: widget.name,
                        ),
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black,
                          indicatorColor: Colors.blue,
                          tabs: const [
                            Tab(text: '메뉴'),
                            Tab(text: '정보'),
                            Tab(text: '리뷰'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              CafeDetailMenu(
                                datas: List<Map<String, dynamic>>.from(
                                    cafeData['menus'] ?? []),
                              ),
                              const Text('카페 정보'),
                              const Text('카페 리뷰'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isTotalWidgetShow)
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                        bottom: 30.0,
                        child: const CafeDetailTotal(),
                      ),
                  ],
                ),
    );
  }
}
