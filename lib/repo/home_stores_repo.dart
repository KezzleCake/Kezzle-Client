import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeStoresRepo {
  // 위도 경도에 맞는 모든 스토어 리스트 가져오기.
  // 목록 더 불러오기
  Future<Map<String, dynamic>> fetchStores({int? page}) async {
    if (page == null) {
      // 첫번째 페이지 가져오기
      return {};
    } else {
      // 다음 페이지 가져오기
      return {};
    }
  }

  // 스토어 좋아요
  Future<void> likeStore(String storeId, User user) async {
    // 스토어 아이디랑 유저정보 받아서 좋아요 처리
    // 여기서 정보 보내기!!
  }
  // 스토어 좋아요 취소
  Future<void> dislikeStore(String storeId, User user) async {
    // 스토어 아이디랑 유저정보 받아서 좋아요 취소 처리
    // 여기서 정보 보내기!!
  }
}

// homeStoreRepo 라는 이름으로, HomeStoresRepo 클래스를 Provider로 등록
final homeStoreRepo = Provider((ref) => HomeStoresRepo());
