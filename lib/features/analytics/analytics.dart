import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Analytics {
  final ProviderRef ref;
  Analytics(this.ref);

  // FirebaseAnalytics get analytics => _analytics;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> gaEvent(
      String eventName, Map<String, dynamic> eventParams) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: eventParams,
    );
    print('이벤트 완료');
  }

  Future<void> gaScreen(String screenName) async {
    try {
      await _analytics.logEvent(
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

  Future<void> logSearch({required String searchTerm}) {
    return _analytics.logSearch(searchTerm: searchTerm);
  }
}

final analyticsProvider = Provider((ref) {
  return Analytics(ref);
});
