import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddressSearchVM {
  // final _googleMapAndroidApiKey = dotenv.env['GOOGLE_MAP_ANDROID_KEY'] ?? '';
  // final _googleMapIosApiKey = dotenv.env['GOOGLE_MAP_IOS_KEY'] ?? '';
  final _googleMapApiKey = dotenv.env['GOOGLE_MAP_API_KEY'] ?? '';
  final _apiKey = dotenv.env['KAKAO_REST_API_KEY'] ?? '';
  final _dio = Dio();

  AddressSearchVM();

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

  //위도 경도로 주소 검색 -> 카카오맵 이용
  // Future<Map<String, dynamic>> searchCurrentLocation(
  //     double longitude, double latitude) async {
  //   final endpoint =
  //       'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$longitude&y=$latitude&input_coord=WGS84';
  //   _dio.options.headers['Authorization'] = 'KakaoAK $_apiKey';

  //   try {
  //     final response = await _dio.get(endpoint);

  //     if (response.statusCode == 200) {
  //       // API 호출 성공
  //       return response.data;
  //     } else {
  //       // API 호출 실패
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     // 에러 처리
  //     print(e);
  //     throw Exception('Failed to load data');
  //   }
  // }

  // 구글 지도 api를 이용한 위도 경도로 주소 검색
  Future<Map<String, dynamic>> searchCurrentLocationGoogleMap(
      double longitude, double latitude) async {
    final endpoint =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleMapApiKey&language=ko';
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
