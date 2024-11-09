import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Return Type: List<Map<String, dynamic>>
class TotalNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  // 초기값 설정
  TotalNotifier() : super([]);

  // 현재 담은 메뉴에서 카페 메뉴 추가
  void addItem(Map<String, dynamic> item) {
    final itemIdx = state.indexWhere((origin) => origin['_id'] == item['_id']);

    if (itemIdx != -1) {
      state = [
        ...state.sublist(0, itemIdx),
        item, // 업데이트된 항목
        ...state.sublist(itemIdx + 1),
      ];
    } else {
      state = [...state, item];
    }
  }

  // 현재 담은 메뉴에서 카페 메뉴 삭제
  void removeItem(String id) {
    state = state.where((item) => item['_id'] != id).toList();
  }
}

// Provider 정의
final totalProvider =
    StateNotifierProvider<TotalNotifier, List<Map<String, dynamic>>>(
  (ref) => TotalNotifier(),
);
