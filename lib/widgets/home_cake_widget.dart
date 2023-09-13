import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';

class HomeCakeWidget extends ConsumerWidget {
  final Cake cakeData;

  const HomeCakeWidget({
    super.key,
    required this.cakeData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // 케이크 클릭 이벤트 로깅
        ref.read(analyticsProvider).gaEvent('click_cake', {
          'cake_id': cakeData.id,
          'cake_store_id': cakeData.ownerStoreId,
        });
        print('케이크 상세보기 페이지로 이동');
        context.push("/detail_cake/${cakeData.id}/${cakeData.ownerStoreId}");
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), boxShadow: [shadow01]),
        clipBehavior: Clip.hardEdge,
        child:
            // Stack(
            // alignment: Alignment.bottomRight,
            // children: [
            Image.network(cakeData.image.s3Url.replaceFirst("https", "http"),
                fit: BoxFit.cover),
        // Image.asset(cakeData.url, fit: BoxFit.cover),
        // Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Stack(children: [
        //       SvgPicture.asset(
        //         'assets/icons/like=on_in.svg',
        //         colorFilter: ColorFilter.mode(
        //           coral01,
        //           BlendMode.srcATop,
        //         ),
        //       ),
        //       SvgPicture.asset('assets/icons/like=off.svg',
        //           colorFilter: const ColorFilter.mode(
        //               Colors.white, BlendMode.srcATop)),
        //     ])),
        // ],
        // ),
      ),
    );
  }
}
