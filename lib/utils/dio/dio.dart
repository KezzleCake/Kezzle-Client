import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  // final tokenref = ref.watch(tokenProvider);
  dio.interceptors.add(CustomInterceptor(ref));
  return dio;
});

class CustomInterceptor extends Interceptor {
  ProviderRef ref;

  CustomInterceptor(
    this.ref,
  );

  //1) 요청을 보낼때(보내기 전)
  // 요청이 보내질때마다,
  // 만약에 요청의 header에 idToken이 true로 되어있으면,
  // idToken을 가져와서 헤더에 authorization을 자동으로 적용해준다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] ${options.method} ${options.path}');
    // 토큰을 자동으로 적용하는 코드
    // if (options.headers['idToken'] == true) {
    // 헤더삭제
    // options.headers.remove('idToken');

    //실제 토큰을 가져와서 헤더에 추가(대체)
    options.baseUrl = dotenv.env['SERVER_ENDPOINT']!;
    options.connectTimeout = const Duration(seconds: 20);
    options.receiveTimeout = const Duration(seconds: 20);
    final token = await ref.read(tokenProvider.notifier).getIdToken();
    options.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    // }

    return super.onRequest(options, handler); // 여기서 요청 보냄
  }

  //2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  //3) 에러가 발생했을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 에러가 났을때,
    // 토큰을 재발급받는 시도를 하고
    // 토큰이 재발급되면 다시 새 토큰으로 요청
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.path}');

    // 만료되면 status코드가 401 이었네요~~

    final isStatus401 = err.response?.statusCode == 401;
    final isStatus502 = err.response?.statusCode == 502;

    if (isStatus502) {
      print("502 에러 발생");
      final dio = Dio();

      final token = await ref.read(tokenProvider.notifier).getIdToken();

      final options = err.requestOptions;
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // 요청 재전송
      try {
        final response = await dio.fetch(options);
        // 성공적 요청을 반환(에러가 안난것처럼 보이게할수있음)
        // print('토큰 재발급 성공 후, 재전송 성공');
        return handler.resolve(response);
      } catch (e) {
        // print('토큰 재발급 실패');
      }
    }

    if (isStatus401) {
      //토큰 만료되는지 확인
      print('토큰 만료됨');
      final dio = Dio();
      // try {
      final token =
          await ref.read(tokenProvider.notifier).getIdToken(newtoken: true);
      // } catch (e) {
      //   // return handler.reject(err);
      //   print('토큰 재발급 실패');
      //   // return handler.reject(error);
      // }
      // 에러 발생한 요청 가져오기
      final options = err.requestOptions;
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // 요청 재전송
      try {
        final response = await dio.fetch(options);
        // 성공적 요청을 반환(에러가 안난것처럼 보이게할수있음)
        print('토큰 재발급 성공 후, 재전송 성공');
        return handler.resolve(response);
      } catch (e) {
        print('토큰 재발급 실패');
      }
    }
    // if (token == null) return handler.reject(err);
    super.onError(err, handler);
  }
}
