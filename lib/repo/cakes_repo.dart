import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/utils/dio/dio.dart';

class CakesRepo {
  final ProviderRef ref;
  CakesRepo(this.ref);

  // 위도 경도에 맞는 모든 케이크 리스트 가져오기.
  Future<List<dynamic>?> fetchCakes({
    required String token,
    required double lat,
    required double lng,
    int? page,
  }) async {
    if (page == null) {
      // 첫번째 페이지 가져오기
      // print(token);
      // var options = BaseOptions(
      //     baseUrl: dotenv.env['SERVER_ENDPOINT']!,
      //     connectTimeout: const Duration(seconds: 20),
      //     receiveTimeout: const Duration(seconds: 20),
      //     headers: {
      //       'Authorization': 'Bearer $token',
      //     });
      // Dio dio = Dio(options);
      Dio dio = ref.watch(dioProvider);
      final queryParams = {
        'latitude': lat,
        'longitude': lng,
        'page': 1,
      };
      try {
        final response = await dio.get('cakes', queryParameters: queryParams);
        if (response.statusCode == 200) {
          return response.data['docs'];
        }
      } catch (e) {
        print(e);
        print('홈화면 케이크 리스트 가져오기 실패');
        return null;
      } finally {
        // dio.close();
      }
      return [{}];
    } else {
      // Page에 맞는거 가져오기
      return [{}];
    }
  }

  // 케이크 좋아요
  Future<bool> likeCake(
      {required String cakeId,
      // required User user,
      required String token}) async {
    // 케이크 아이디랑 유저정보 받아서 좋아요 처리
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
      final response = await dio.post('cakes/$cakeId/likes');
      if (response.statusCode == 201) {
        print('케이크 좋아요 성공');
        return true;
      }
    } catch (e) {
      print(e);
      print('케이크 좋아요 실패');
      return false;
    } finally {
      // dio.close();
    }
    return false;
  }

  // 케이크 좋아요 취소
  Future<bool> dislikeCake(
      {required String cakeId,
      // required User user,
      required String token}) async {
    // 케이크 아이디랑 유저정보 받아서 좋아요 취소 처리
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
      final response = await dio.delete('cakes/$cakeId/likes');
      if (response.statusCode == 200) {
        print('케이크 좋아요 취소 성공');
        return true;
      }
    } catch (e) {
      print(e);
      print('케이크 좋아요 취소 실패');
      return false;
    } finally {
      // dio.close();
    }
    return false;
  }

  // 사용자가 찜한 케이크 리스트 가져오기
  Future<List<dynamic>?> fetchBookmarkedCakes({
    required String token,
    required User user,
    int? page,
  }) async {
    // 사용자 정보 받아서 찜한 케이크 리스트 가져오기
    if (page == null) {
      // 첫번째 페이지 가져오기 -> 이거는 페이지네이션 아님. 근데 일단? 혹시 몰라서 page 넣어둠.
      // 여기서 api 요청 보내기!
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
        final response = await dio.get('users/${user.uid}/liked-cakes');
        if (response.statusCode == 200) {
          print('유저가 좋아요한 케이크 가져오기 성공');
          // print(response.data);
          return response.data;
        }
      } catch (e) {
        print(e);
        print('유저가 좋아요한 케이크 가져오기 실패');
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

  Future<List<dynamic>?> fetchCakesByStoreId(
      {required String storeId /*, required String token*/}) async {
    // 스토어 아이디 받아서 해당 스토어의 케이크 리스트 가져오기
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
      final response = await dio.get('stores/$storeId/cakes');
      if (response.statusCode == 200) {
        print('매장의 케이크 정보 불러오기 성공');
        return response.data;
      }
    } catch (e) {
      print(e);
      print('매장의 케이크 정보 불러오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // ID로 케이크 정보 가져오기
  Future<Map<String, dynamic>?> fetchCakeById(
      {required String cakeId, required String token}) async {
    // 스토어 아이디 받아서 해당 스토어의 케이크 리스트 가져오기
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
      final response = await dio.get('cakes/$cakeId');
      if (response.statusCode == 200) {
        print('케이크 아이디로 케이크 정보 불러오기 성공');
        return response.data;
      }
    } catch (e) {
      print(e);
      print('케이크 아이디로 케이크 정보 불러오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // 스토어 ID로 스토어의 다른 케이크 정보 가져오기
  Future<List<dynamic>?> fetchAnotherStoreCakes(
      {required String storeId, required String token}) async {
    // 스토어 아이디 받아서 해당 스토어의 케이크 리스트 가져오기
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
      final response = await dio.get('stores/$storeId/cakes');
      if (response.statusCode == 200) {
        print('스토어 아이디로 스토어의 다른 케이크들 불러오기 성공');
        return response.data;
      }
    } catch (e) {
      print(e);
      print('스토어 아이디로 스토어의 다른 케이크들 불러오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }
}

// cakesRepo 라는 이름으로, CakesRepo 클래스를 Provider로 등록
final cakesRepo = Provider((ref) => CakesRepo(ref));
