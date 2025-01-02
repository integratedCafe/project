import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalNotifier extends StateNotifier<Map<String, dynamic>> {
  TotalNotifier() : super({});

  /// 카페를 추가 및 데이터 추가
  void addItem(Map<String, dynamic> cafe) {
    if (state.isEmpty) {
      // 첫 항목 추가 시 cafe 정보만 저장
      state = {
        'cafe': {
          ...cafe,
          'menus': cafe['menus'], // menus 배열만 저장
        }
      };
    } else {
      final existingMenus =
          List<Map<String, dynamic>>.from(state['cafe']['menus']);

      // orElse 수정
      final updatedMenu = cafe['menus'].firstWhere(
        (menu) => menu['isAdd'] == true,
        orElse: () => <String, dynamic>{}, // 빈 Map 반환
      );

      if (updatedMenu.isNotEmpty) {
        // null 체크 대신 isEmpty 체크
        final existingIndex = existingMenus
            .indexWhere((item) => item['_id'] == updatedMenu['_id']);

        if (existingIndex != -1) {
          existingMenus[existingIndex] = {
            ...updatedMenu,
            'isAdd': true,
            'qty': updatedMenu['qty'] ?? 1,
          };
        } else {
          existingMenus.add({
            ...updatedMenu,
            'isAdd': true,
            'qty': updatedMenu['qty'] ?? 1,
          });
        }

        state = {
          'cafe': {
            ...state['cafe'],
            'menus': existingMenus,
          }
        };
      }
    }
  }

  /// cart에서 아이템을 제거할 때
  void removeItem(String menuId) {
    final cafe = state['cafe'];
    if (cafe != null && cafe['menus'] != null) {
      final menus = List<Map<String, dynamic>>.from(cafe['menus']);

      final index = menus.indexWhere((item) => item['_id'] == menuId);
      if (index != -1) {
        menus[index]['isAdd'] = false;
        menus[index]['qty'] = 0;

        // 데이터 갱신
        state = {
          ...state,
          'cafe': {
            ...cafe,
            'menus': menus,
          },
        };
      }
    }
  }
}

// Provider 정의
final totalProvider =
    StateNotifierProvider<TotalNotifier, Map<String, dynamic>>(
  (ref) => TotalNotifier(),
);
