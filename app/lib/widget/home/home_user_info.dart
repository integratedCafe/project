import 'package:flutter/material.dart';

// Widget
import 'package:intergrate_cafe/widget/home/home_my.dart';

// Util
import 'package:intergrate_cafe/util/color.dart';

class HomeUserInfo extends StatefulWidget {
  final List<Map<String, String>> frequencyImages;
  final List<Map<String, String>> favoriteImages;

  const HomeUserInfo(
      {super.key,
      this.frequencyImages = const [],
      this.favoriteImages = const []});

  @override
  _HomeUserInfoState createState() => _HomeUserInfoState();
}

class _HomeUserInfoState extends State<HomeUserInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 410,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '윤제혁',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text('내 포인트 1000 점', style: TextStyle(fontSize: 16)),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: ColorH.main(),
                        indicatorWeight: 3.0,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                            text: '자주 가는 매장',
                          ),
                          Tab(
                            text: '저장한 메뉴',
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 링크 클릭시 액션
                      },
                      child: Text(
                        '전체보기',
                        style: TextStyle(
                          color: ColorH.main(),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: double.maxFinite,
                  constraints: const BoxConstraints(
                    minHeight: 50.0,
                    maxHeight: 290,
                  ),
                  child: TabBarView(
                    children: [
                      HomeMy(
                          tabList: widget.frequencyImages, type: 'frequency'),
                      HomeMy(tabList: widget.favoriteImages, type: 'favorite'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
