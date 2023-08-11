import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoreLocation extends StatelessWidget {
  final apiKey = dotenv.env['KAKAO_JAVASCRIPT_KEY'] ?? '';
  final DetailStoreModel store;

  StoreLocation({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36 / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 30),
          Text(
            store.address,
            // '서울 서대문구 신촌로 1 쓰리알유씨티아파트상가건물 2층 204호',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: gray06),
          ),
          const SizedBox(height: 16),
          // Container(
          //     clipBehavior: Clip.hardEdge,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(16), color: Colors.grey),
          //     height: 300,
          //     width: double.infinity,
          //     child: const Center(
          //       child: Text('지도'),
          //     )),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: KakaoMapView(
              width: double.infinity,
              height: 300,
              kakaoMapKey: apiKey,
              lat: store.latitude,
              lng: store.longitude,
              // showMapTypeControl: true,
              // showZoomControl: true,
              zoomLevel: 2,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              await launchUrlString(store.kakaoMapURL!);
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: gray04),
                    borderRadius: BorderRadius.circular(16)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const FaIcon(FontAwesomeIcons.locationDot,
                        size: 15, color: Colors.blue),
                  ]),
                  const SizedBox(width: 6),
                  Text('장소 정보 자세히 보기',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gray06)),
                ])),
          ),
        ]));
  }
}
