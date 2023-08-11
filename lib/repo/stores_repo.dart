import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/utils/dio/dio.dart';
// import 'package:kezzle/utils/dio/dio.dart';
// import 'package:kezzle/view_models/id_token_provider.dart';

class StoreRepo {
  final ProviderRef ref;
  StoreRepo(this.ref);

  // 위도 경도에 맞는 모든 스토어 리스트 가져오기.
  // 위도 경도 받아야됨..
  // 목록 더 불러오기
  Future<Map<String, dynamic>?> fetchStores({
    // String? afterId,
    double? afterDistance,
    required int count,
    required double lat,
    required double lng,
  }) async {
    // 처음 요청은 아이디 없이 보내기
    Dio dio = ref.watch(dioProvider);
    if (afterDistance == null) {
      final queryParams = {
        // 'after': afterId,
        'count': 8,
        'latitude': lat,
        'longitude': lng,
      };
      try {
        final response = await dio.get('stores', queryParameters: queryParams);
        if (response.statusCode == 200) {
          // print('홈화면 스토어 목록 가져오기 성공');
          // print(response.data);
          return response.data;
        }
      } catch (e) {
        print(e);
        print('홈화면 스토어 목록 가져오기 실패');
        return null;
      } finally {
        // dio.close();
      }
      return {};
    } else {
      // 특정 아이디 다음 것 가져오기
      final queryParams = {
        'after': afterDistance,
        'count': 8,
        'latitude': lat,
        'longitude': lng,
      };
      try {
        final response = await dio.get('stores', queryParameters: queryParams);
        if (response.statusCode == 200) {
          print('스토어 정보 가져오기 성공');
          // print(response.data);
          return response.data;
        }
      } catch (e) {
        print(e);
        print('스토어 정보 가져오기 실패');
        return null;
      } finally {
        // dio.close();
      }

      return {};
    }
  }

  // 스토어 좋아요
  Future<String> likeStore(String storeId, String token) async {
    // 스토어 아이디랑 유저정보 받아서 좋아요 처리
    // 여기서 정보 보내기!!
    // var options = BaseOptions(
    //   baseUrl: dotenv.env['SERVER_ENDPOINT']!,
    //   connectTimeout: const Duration(seconds: 20),
    //   receiveTimeout: const Duration(seconds: 20),
    //   headers: {
    //     'Authorization': 'Bearer $token',
    //   },
    // );
    // Dio dio = Dio(options);
    Dio dio = ref.watch(dioProvider);

    try {
      final response = await dio.post('stores/$storeId/likes');
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('스토어 좋아요 성공');
        return response.data;
      }
    } catch (e) {
      print(e);
      print('스토어 좋아요 실패');
      return 'false';
    } finally {
      // dio.close();
    }
    return 'false';
  }

  // 스토어 좋아요 취소
  Future<Response<dynamic>?> dislikeStore(String storeId, String token) async {
    // 스토어 아이디랑 유저정보 받아서 좋아요 취소 처리
    // 여기서 정보 보내기!!
    // var options = BaseOptions(
    //     baseUrl: dotenv.env['SERVER_ENDPOINT']!,
    //     connectTimeout: const Duration(seconds: 20),
    //     receiveTimeout: const Duration(seconds: 20),
    //     headers: {
    //       'Authorization': 'Bearer $token',
    //     });
    // Dio dio = Dio(options);
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.delete('stores/$storeId/likes');
      if (response.statusCode == 200) {
        print('스토어 좋아요 취소 성공');
        print(response.data);
        return response;
      }
    } catch (e) {
      print(e);
      print('스토어 좋아요 취소 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // 사용자가 찜한 스토어 리스트 가져오기
  Future<List<dynamic>?> fetchBookmarkedStores(
      {required User user,
      required double lat,
      required double lng,
      int? page}) async {
    // 사용자 정보, 위도 경도 받아서 찜한 스토어 리스트 가져오기
    if (page == null) {
      // 첫번째 페이지 가져오기 -> 이거는 페이지네이션 아님. 근데 일단? 혹시 몰라서 page 넣어둠.
      // 여기서 api 요청 보내기!
      // var options = BaseOptions(
      //     baseUrl: dotenv.env['SERVER_ENDPOINT']!,
      //     connectTimeout: const Duration(seconds: 20),
      //     receiveTimeout: const Duration(seconds: 20),
      //     headers: {
      //       'Authorization': 'Bearer ${await user.getIdToken()}',
      //     });
      // Dio dio = Dio(options);
      Dio dio = ref.watch(dioProvider);
      final queryParams = {
        'latitude': lat,
        'longitude': lng,
      };
      try {
        final response = await dio.get('users/${user.uid}/liked-stores',
            queryParameters: queryParams);
        if (response.statusCode == 200) {
          // print('유저가 좋아요한 스토어 정보 가져오기 성공');
          // print(response.data);
          return response.data;
        }
      } catch (e) {
        print(e);
        // print('유저가 좋아요한 스토어 정보 가져오기 실패');
        return null;
      } finally {
        // dio.close();
      }
      return [{}];
    } else {
      // page에 맞는거 가져오기
      // 특정(다음) 페이지 가져오기
      return [{}];
    }
  }

  // 스토어 상세 정보 가져오기
  Future<Map<String, dynamic>?> fetchDetailStore(
      {required String storeId,
      // required String token,
      required lat,
      required lng}) async {
    // var options = BaseOptions(
    //     baseUrl: dotenv.env['SERVER_ENDPOINT']!,
    //     connectTimeout: const Duration(seconds: 20),
    //     receiveTimeout: const Duration(seconds: 20),
    //     headers: {
    //       'Authorization': 'Bearer $token',
    //     });
    // Dio dio = Dio(options);
    Dio dio = ref.read(dioProvider);
    final queryParams = {
      'latitude': lat,
      'longitude': lng,
    };
    try {
      final response =
          await dio.get('stores/$storeId', queryParameters: queryParams);
      if (response.statusCode == 200) {
        print('스토어 상세 정보 가져오기 성공');
        // print(response.data);
        return response.data;
      }
    } catch (e) {
      print(e);
      print('스토어 상세 정보 가져오기 실패');
      // return null;
    } finally {
      // dio.close();
    }
    return null;
  }
}

// homeStoreRepo 라는 이름으로, HomeStoresRepo 클래스를 Provider로 등록
final storeRepo = Provider((ref) => StoreRepo(ref));
