import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kezzle/firebase_options.dart';
// import 'package:kezzle/features/authentication/login_screen.dart';
// import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/router.dart';
import 'package:kezzle/utils/colors.dart';

void main() async {
  // 화면 세로 고정
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env"); // .env 파일 로드
  // runApp(const KezzleApp());

  initializeDateFormatting().then((_) => runApp(KezzleApp()));
}

class KezzleApp extends StatelessWidget {
  const KezzleApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
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
            color: gray08,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // home: LoginScreen(),
      // home: const MobileScreenLayout(),
    );
  }
}
