import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/utils/dio/dio.dart';

class RanksRepo {
  final ProviderRef ref;
  RanksRepo(this.ref);

  Future<Map<String, dynamic>?> fetchRankingList() async {
    Dio dio = ref.watch(dioProvider);
    try {
      final response = await dio.get('search/rank');
      if (response.statusCode == 200) {
        print('랭킹 리스트 가져오기 성공');
        // print(response.data);
        return response.data;
      }
    } catch (e) {
      print(e);
      print('랭킹 리스트 가져오기 실패');
    }
    return null;
  }
}

final ranksRepo = Provider((ref) => RanksRepo(ref));
