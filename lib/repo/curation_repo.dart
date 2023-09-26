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
}

// 프로바이더 등록
final curationRepo = Provider((ref) => CurationRepo(ref));
