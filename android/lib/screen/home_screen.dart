import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Widget
import 'package:intergrate_cafe/widget/home/home_my.dart';
import 'package:intergrate_cafe/widget/home/home_near_by.dart';

// Util
import 'package:intergrate_cafe/util/color.dart';
import 'package:intergrate_cafe/util/api.dart';

final List<String> promotionImagePaths = [
  'images/home/banner1.webp',
  'images/home/banner2.webp',
  'images/home/banner3.webp',
  'images/home/banner1.webp',
  'images/home/banner2.webp',
  'images/home/banner3.webp',
];

final List<Map<String, String>> frequencyImages = [
  {'image': 'images/home/k1.jpg', 'name': '메머드', 'distance': '136.4m'},
  {'image': 'images/home/k2.jpg', 'name': '스타벅스', 'distance': '261.2m'},
  {'image': 'images/home/k3.jpg', 'name': '메가커피', 'distance': '401.4m'},
  {'image': 'images/home/k1.jpg', 'name': '메머드', 'distance': '421.2m'},
  {'image': 'images/home/k2.jpg', 'name': '스타벅스', 'distance': '440.9m'},
  {'image': 'images/home/k3.jpg', 'name': '메가커피', 'distance': '500.5m'},
];

final List<Map<String, String>> favoriteImages = [
  {'image': 'images/home/c1.jpg', 'name': '아메리카노', 'option': '없음'},
  {'image': 'images/home/c2.jpg', 'name': '아메리카노', 'option': '샷추가 + 1'},
  {'image': 'images/home/c3.jpg', 'name': '꿀메리카노', 'option': '없음'},
  {'image': 'images/home/c1.jpg', 'name': '자몽허니블랙티', 'option': '클래식 시럽 - 1'},
  {'image': 'images/home/c2.jpg', 'name': '아메리카노', 'option': '얼음 많이'},
  {'image': 'images/home/c3.jpg', 'name': '요거트 스무디', 'option': '저지방'},
];

final List<Map<String, String>> nearByList = [
  {
    'image': 'images/home/c1.jpg',
    'name': '스타벅스 슈피겐점',
    'take': 'Take Out / Take In',
    'distance': '23.1m'
  },
  {
    'image': 'images/home/c2.jpg',
    'name': '메머드 선정릉역점',
    'take': 'Take Out',
    'distance': '56.5m'
  },
  {
    'image': 'images/home/c3.jpg',
    'name': '메머드 선릉역점',
    'take': 'Take Out',
    'distance': '120.3m'
  },
  {
    'image': 'images/home/c1.jpg',
    'name': '윤제혁 포스코점',
    'take': 'Take Out / Take In',
    'distance': '140.8m'
  },
  {
    'image': 'images/home/c2.jpg',
    'name': '메가커피 선릉역점',
    'take': 'Take Out',
    'distance': '180.0m'
  },
  {
    'image': 'images/home/c3.jpg',
    'name': '백다방 선릉점',
    'take': 'Take Out',
    'distance': '202.9m'
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 데이터를 초기화하는 메소드 호출
    print("Init State!");
    _testLogin();
  }

  Future<void> _testLogin() async {
    print('Init Test Login');
    dynamic res = await ApiService()
        .post('/user/login', {'phone': '01027977760', 'password': 'password'});

    print('Login Response >>>> $res');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildPromotionCarousel(),
            const SizedBox(height: 32),
            _buildUserInfoTabBar(context),
            const SizedBox(height: 32),
            HomeNearBy(nearByList: nearByList)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorH.main(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: '나는 꿀커피가 좋아졌다...',
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionCarousel() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
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
          child: CarouselSlider(
            items: promotionImagePaths.map((path) {
              return Image.asset(
                path,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              viewportFraction: 1.0,
            ),
          ),
        ));
  }

  Widget _buildUserInfoTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
                padding: EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '윤제혁',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text('내 포인트 1000 점', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
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
                constraints: BoxConstraints(
                  minHeight: 100.0, // 원하는 최소 높이
                  maxHeight: MediaQuery.of(context).size.height *
                      0.5, // 화면 높이의 50%까지 확장
                ),
                child: TabBarView(
                  children: [
                    HomeMy(tabList: frequencyImages, type: 'frequency'),
                    HomeMy(tabList: favoriteImages, type: 'favorite'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
