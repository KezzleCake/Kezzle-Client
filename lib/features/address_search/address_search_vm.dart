import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressSearchViewModel {
  final _apiKey = dotenv.env['KAKAO_REST_API_KEY'] ?? '';
  final _dio = Dio();

  AddressSearchViewModel();

  Future<Map<String, dynamic>> searchAddress(String keyword) async {
    final endpoint =
        'https://dapi.kakao.com/v2/local/search/address.json?query=$keyword&analyze_type=similar';

    _dio.options.headers['Authorization'] = 'KakaoAK $_apiKey';

    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        // API 호출 성공
        return response.data;
      } else {
        // API 호출 실패
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // 에러 처리
      print(e);
      throw Exception('Failed to load data');
    }
  }
}
