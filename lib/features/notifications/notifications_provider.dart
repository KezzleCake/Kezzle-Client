import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  // db
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    if (user != null) {
      // 받아온 토큰 데이터로 유저 정보 업데이트
    }
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    // foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I just got a message and I'm in the foreground!");
      print(event.notification?.title);
    });

    // background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage notification) {
      print("I just got a message and I'm in the background!");
      // print(notification.data['screen']);
      // context.go('/chat');
      // context.push('/map');
    });

    // terminated. 앱이 알림에 의해 실행됐는지
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      print("I just got a message and I'm terminated!");
      // print(notification.data['screen']);
      // context.go('settings');
      // context.goNamed('/home');
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    final token = await _messaging.getToken();
    print('token: $token');
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
