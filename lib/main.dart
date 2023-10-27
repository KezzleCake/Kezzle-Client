import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/notifications/notifications_provider.dart';
import 'package:kezzle/firebase_options.dart';
import 'package:kezzle/repo/current_keyword_repo.dart';
import 'package:kezzle/repo/search_setting_repo.dart';
import 'package:kezzle/repo/searched_address_repo.dart';
import 'package:kezzle/router.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/currnet_keyword_view_model.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/view_models/searched_address_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 알림 위해 추가
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("백그라운드 메시지 처리.. ${message.notification!.body!}");
// }

// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// void initializeNotification() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//           'high_importance_channel', 'high_importance_notification',
//           importance: Importance.max));

//   await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   ));

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }

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
  // ...
  final repository = SearchSettingRepository(preferences);
  final repository2 = SearchedAddressRepository(preferences);
  final repository3 = CurrentKeywordRepository(preferences);

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
      recentKeywordRecordProvider
          .overrideWith(() => RecentKeywordRecordNotifier(repository3)),
    ],
    child: KezzleApp(),
  ));
}

class KezzleApp extends ConsumerWidget {
  const KezzleApp({super.key});

  //final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
