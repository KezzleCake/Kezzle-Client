import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Analytics {
  final ProviderRef ref;
  Analytics(this.ref);

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> gaEvent(
      String eventName, Map<String, dynamic> eventParams) async {
    await analytics.logEvent(
      name: eventName,
      parameters: eventParams,
    );
    print('이벤트 완료');
  }

  Future<void> gaScreen(String screenName) async {
    try {
      await analytics.logEvent(
        name: 'screen_view',
        parameters: {
          'firebase_screen': screenName,
          // 'firebase_screen_class': screenClass,
        },
      );
    } catch (e) {
      print(e);
    }
    print('화면 전환 로깅 완료');
  }
}

final analyticsProvider = Provider((ref) {
  return Analytics(ref);
});
