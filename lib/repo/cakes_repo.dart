import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CakesRepo {
  // 위도 경도에 맞는 모든 케이크 리스트 가져오기.
  Future<Map<String, dynamic>> fetchCakes({int? page}) async {
    if (page == null) {
      // 첫번째 페이지 가져오기
      return {};
    } else {
      // 특정 페이지 가져오기
      return {};
    }
  }

  // 케이크 좋아요
  Future<void> likeCake(String cakeId, User user) async {
    // 케이크 아이디랑 유저정보 받아서 좋아요 처리
    // 여기서 정보 보내기!!
  }
  // 케이크 좋아요 취소
  Future<void> dislikeCake(String cakeId, User user) async {
    // 케이크 아이디랑 유저정보 받아서 좋아요 취소 처리
    // 여기서 정보 보내기!!
  }

  // 사용자가 찜한 케이크 리스트 가져오기
  Future<List<String>> fetchBookmarkedCakes(User user) async {
    // 사용자 정보 받아서 찜한 케이크 리스트 가져오기
    return [];
  }
}

// cakesRepo 라는 이름으로, CakesRepo 클래스를 Provider로 등록
final cakesRepo = Provider((ref) => CakesRepo());
