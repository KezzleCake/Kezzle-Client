import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/firebase_options.dart';
import 'package:kezzle/repo/search_setting_repo.dart';
import 'package:kezzle/router.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Kezzle',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: ".env"); // .env 파일 로드
  final preferences = await SharedPreferences.getInstance();
  final repository = SearchSettingRepository(preferences);

  // 화면 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(ProviderScope(
    overrides: [
      searchSettingViewModelProvider
          .overrideWith(() => SearchSettingViewModel(repository)),
    ],
    child: KezzleApp(),
  ));
}

class KezzleApp extends ConsumerWidget {
  const KezzleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Kezzle',
      theme: ThemeData(
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
      // home: LoginScreen(),
      // home: const MobileScreenLayout(),
    );
  }
}
