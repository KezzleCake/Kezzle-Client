import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/utils/dio/dio.dart';

class CurationRepo {
  final ProviderRef ref;
  CurationRepo(this.ref);

  Future<Map<String, dynamic>> fetchCurationCakes({
    required int curationId,
  }) async {
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('curation/$curationId');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('하나의 큐레이션 케이크 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchCurations() async {
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('curation');
      if (response.statusCode == 200) {
        print('큐레이션 리스트 가져오기 성공');
        // print(response.data);
        return response.data;
      }
    } catch (e) {
      print(e);
      print('큐레이션 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>?> fetchAnniversaryCakes({
    required String curationId,
  }) async {
    Dio dio = ref.watch(dioProvider);

    try {
      final response = await dio.get('cakes/anniversary/$curationId');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('하나의 큐레이션 케이크 리스트 가져오기 실패');
    }
    return null;
  }

  Future<Map<String, dynamic>> fetchCurationCakesById({
    required String curationId,
    required int page,
  }) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = {
      'page': page,
    };
    try {
      final response =
          await dio.get('curation/$curationId', queryParameters: queryParams);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('하나의 큐레이션 케이크 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchAnniversaryCakesById({
    required String curationId,
    required int page,
  }) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = {
      'page': page,
    };
    try {
      final response = await dio.get('cakes/anniversary/$curationId',
          queryParameters: queryParams);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('기념일 케이크 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchPopularCakes({
    required double? lastCursor,
  }) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = {
      'after': lastCursor,
    };
    try {
      final response =
          await dio.get('cakes/popular', queryParameters: queryParams);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('인기 케이크 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>> fetchNewCakes({
    required String? lastCakeId,
  }) async {
    Dio dio = ref.watch(dioProvider);
    final queryParams = lastCakeId == null
        ? {
            'count': 20,
          }
        : {
            'after': lastCakeId,
            'count': 20,
          };
    try {
      final response =
          await dio.get('cakes/newest', queryParameters: queryParams);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('최근등록된 케이크 리스트 가져오기 실패');
    }
    return {};
  }

  Future<Map<String, dynamic>?> fetchHomeData() async {
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('v2/curation');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      print('홈 데이터 가져오기 실패');
      return null;
    }
    return {};
  }
}

// 프로바이더 등록
final curationRepo = Provider((ref) => CurationRepo(ref));
