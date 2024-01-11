import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/dio/dio.dart';

class CakesRepo {
  final ProviderRef ref;
  CakesRepo(this.ref);

  // 위도 경도에 맞는 모든 케이크 리스트 가져오기.
  Future<Map<String, dynamic>?> fetchCakes({
    required int count,
    String? afterId,
    required double lat,
    required double lng,
    required int dist,
  }) async {
    Dio dio = ref.watch(dioProvider);
    if (afterId == null) {
      final queryParams = {
        'latitude': lat,
        'longitude': lng,
        // 'after': ,
        'count': 18,
        'dist': dist * 1000,
      };
      try {
        final response = await dio.get('cakes', queryParameters: queryParams);
        if (response.statusCode == 200) {
          // print(response);
          return response.data;
          // return response.data['docs'];
        }
      } catch (e) {
        print(e);
        print('홈화면 케이크 리스트 가져오기 실패');
        return null;
      } finally {
        // dio.close();
      }
      // return [{}];
      return {};
    } else {
      final queryParams = {
        'latitude': lat,
        'longitude': lng,
        'after': afterId,
        'count': 18,
        'dist': dist * 1000,
      };
      try {
        final response = await dio.get('cakes', queryParameters: queryParams);
        if (response.statusCode == 200) {
          // print(response);
          return response.data;
          // return response.data['docs'];
        }
      } catch (e) {
        print(e);
        print('홈화면 케이크 리스트 가져오기 실패');
        return null;
      } finally {}
      return {};
    }
  }

  // 케이크 좋아요
  Future<bool> likeCake({
    required String cakeId,
  }) async {
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
  Future<bool> dislikeCake({
    required String cakeId,
  }) async {
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
    required User user,
    int? page,
  }) async {
    // 사용자 정보 받아서 찜한 케이크 리스트 가져오기
    if (page == null) {
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

  Future<Map<String, dynamic>?> fetchCakesByStoreId({
    required String storeId,
    required int count,
    String? afterId,
  }) async {
    // 스토어 아이디 받아서 해당 스토어의 케이크 리스트 가져오기
    Dio dio = ref.watch(dioProvider);
    if (afterId == null) {
      final queryParams = {
        'count': 18,
      };
      try {
        final response = await dio.get('stores/$storeId/cakes',
            queryParameters: queryParams);
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
    } else {
      print('더있어서 요청');
      final queryParams = {
        'count': 18,
        'after': afterId,
      };
      try {
        final response = await dio.get('stores/$storeId/cakes',
            queryParameters: queryParams);
        if (response.statusCode == 200) {
          print('매장의 케이크 정보 불러오기 성공');
          // print(response.data);
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
  }

  // ID로 케이크 정보 가져오기
  Future<Map<String, dynamic>?> fetchCakeById({required String cakeId}) async {
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
      {required String storeId}) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = {
      'count': 4,
    };
    try {
      final response =
          await dio.get('stores/$storeId/cakes', queryParameters: queryParams);
      // print(response.data);
      if (response.statusCode == 200) {
        print('스토어 아이디로 스토어의 다른 케이크들 불러오기 성공');
        return response.data['cakes'];
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

  //유사케이크 가져오기
  Future<Map<String, dynamic>?> fetchSimilarCakes({
    required String cakeId,
    required double lat,
    required double lng,
    required double dist,
  }) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = {
      'latitude': lat,
      'longitude': lng,
      'dist': dist,
      'size': 6,
    };
    try {
      final response =
          await dio.get('cakes/$cakeId/similar', queryParameters: queryParams);
      if (response.statusCode == 200) {
        print('유사케이크 가져오기 성공');
        return response.data;
      }
    } catch (e) {
      print(e);
      print('유사케이크 가져오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // 인기케이크 가져오기
  Future<Map<String, dynamic>?> fetchPopularCakes() async {
    Dio dio = ref.watch(dioProvider);

    try {
      final response = await dio.get('cakes/popular');
      if (response.statusCode == 200) {
        print('인기 케이크 가져오기 성공');
        // print(response.data);
        return response.data;
      }
    } catch (e) {
      // print(e);
      print('인기 케이크 가져오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  Future<SerachCakesVO?> searchCakes(
      {required List<String> keywords, int? page}) async {
    Dio dio = ref.watch(dioProvider);

    print("[$keywords] 적용 되어 검색!");
    final queryParams = {
      'keyword': keywords.join(', '),
      'page': page ?? 0,
    };
    try {
      final response = await dio.get('search', queryParameters: queryParams);
      if (response.statusCode == 200) {
        print('케이크 검색 성공');
        // print(response.data);
        final result = response.data as Map<String, dynamic>?;
        if (result == null) return null;
        final cakes = (result['cakes'] as List)
            .map((e) => Cake.fromJson(e as Map<String, dynamic>))
            .toList();
        print('가져온 케이크 갯수: ${cakes.length}');
        return SerachCakesVO(
          cakes: cakes,
          hasMore: result['hasMore'] as bool,
          nextPage: result['nextPage'] as int,
        );
      }
    } catch (e) {
      // print(e);
      print('케이크 검색 실패');
      // return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // 특정 큐레이션 케이크 가져오기
  Future<Map<String, dynamic>?> fetchCoverCakes(
      {required String coverId}) async {
    Dio dio = ref.watch(dioProvider);

    try {
      final response = await dio.get('curation/$coverId');
      if (response.statusCode == 200) {
        print('특정 큐레이션 케이크 가져오기 성공');
        // print(response.data);
        return response.data;
      }
    } catch (e) {
      // print(e);
      print('특정 큐레이션 케이크 가져오기 실패');
      return null;
    } finally {
      // dio.close();
    }
    return null;
  }

  // 케이크 삭제
  Future<bool> deleteCake({required String cakeId}) async {
    Dio dio = ref.watch(dioProvider);

    try {
      final response = await dio.delete('cakes/$cakeId');
      if (response.statusCode == 200) {
        print('케이크 삭제 성공');
        return true;
      }
    } catch (e) {
      print(e);
      print('케이크 삭제 실패');
      return false;
    } finally {
      // dio.close();
    }
    return false;
  }
}

// cakesRepo 라는 이름으로, CakesRepo 클래스를 Provider로 등록
final cakesRepo = Provider((ref) => CakesRepo(ref));

class SerachCakesVO {
  final List<Cake> cakes;
  final bool hasMore;
  final int nextPage;

  SerachCakesVO({
    required this.cakes,
    required this.hasMore,
    required this.nextPage,
  });

  @override
  String toString() {
    return "SerachCakesVO{cakes: $cakes, hasMore: $hasMore, nextPage: $nextPage}";
  }
}
