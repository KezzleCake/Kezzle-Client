import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/firebase_options.dart';
import 'package:kezzle/repo/search_setting_repo.dart';
import 'package:kezzle/repo/searched_address_repo.dart';
import 'package:kezzle/router.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/view_models/searched_address_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 10;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Kezzle',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env"); // .env 파일 로드

  // 코드 너무 막장이다... 고칠방법을 생각해보자..
  final preferences = await SharedPreferences.getInstance();
  final repository = SearchSettingRepository(preferences);
  final repository2 = SearchedAddressRepository(preferences);

  // 화면 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(ProviderScope(
    // observers: [
    //   Logger(),
    // ],
    overrides: [
      searchSettingViewModelProvider
          .overrideWith(() => SearchSettingViewModel(repository)),
      searchedHistoryAddressVMProvider
          .overrideWith(() => SearchedAddressVM(repository2)),
    ],
    child: const KezzleApp(),
  ));
}

class KezzleApp extends ConsumerWidget {
  const KezzleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      title: 'Kezzle',
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(color: coral01),
        fontFamily: 'Pretendard',
        useMaterial3: true,
        primaryColor: const Color(0xffFDDA81),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: coral01,
        ),
        scaffoldBackgroundColor: const Color(0xffFFFFFF),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: const Color(0xffFFFFFF),
          titleTextStyle: TextStyle(
              color: gray08, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
