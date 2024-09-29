import 'package:flutter/material.dart';

// Util
import 'package:intergrate_cafe/util/api.dart';

// Widget
import 'package:intergrate_cafe/widget/common/search_bar.dart'
    as CommonSearchBar;
import 'package:intergrate_cafe/widget/cafe/cafe_list_item.dart';

class CafeList extends StatefulWidget {
  const CafeList({super.key});

  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _items = [];
  int totalCount = 0;
  int _pageNumber = 1;
  bool _isLoading = false;
  int _selectedSortIndex = 0;

  final List<String> sortOptions = [
    '기본순',
    '리뷰순',
    '최신순',
    '거리순',
  ];

  @override
  void initState() {
    super.initState();
    _getCafeList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        if (_items.length != totalCount) {
          _pageNumber += 1;
          _getCafeList();
        }
      }
    });
  }

  Future<void> _getCafeList() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    dynamic response = await ApiService().get('/cafe/skip/$_pageNumber');
    totalCount = response['total'];
    List<dynamic> cafes = response['cafes'];
    List<Map<String, dynamic>> cafesList =
        List<Map<String, dynamic>>.from(cafes);
    setState(() {
      _items.addAll(cafesList);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSortOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int index = 0; index < sortOptions.length; index++)
                    ListTile(
                      title: Text(sortOptions[index]),
                      onTap: () {
                        setState(() {
                          _selectedSortIndex = index;
                        });
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const CommonSearchBar.SearchBar(),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showSortOptionsModal(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('정렬: ${sortOptions[_selectedSortIndex]}'),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _items.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _items.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CafeListItem(
                    name: _items[index]['name'],
                    location: _items[index]['location'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
