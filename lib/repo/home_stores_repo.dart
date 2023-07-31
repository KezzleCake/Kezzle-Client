import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStoresRepo {
  // 위도 경도에 맞는 모든 스토어 리스트 가져오기.
  Future<Map<String, dynamic>> fetchStores() async {
    return {};
  }
}

// homeStoreRepo 라는 이름으로, HomeStoresRepo 클래스를 Provider로 등록
final homeStoreRepo = Provider((ref) => HomeStoresRepo());
