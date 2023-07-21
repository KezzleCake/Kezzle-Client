import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/utils/colors.dart';

class StoreLocation extends StatelessWidget {
  const StoreLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36 / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            '서울 서대문구 신촌로 1 쓰리알유씨티아파트상가건물 2층 204호',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gray06,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey,
            ),
            height: 300,
            width: double.infinity,
            child: const Center(
              child: Text('지도'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: gray04,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: 15,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '장소 정보 자세히 보기',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray06,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
