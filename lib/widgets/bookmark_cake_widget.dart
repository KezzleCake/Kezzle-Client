import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/cake_vm.dart';

class BookmarkCakeWidget extends ConsumerWidget {
  final Cake cakeData;

  const BookmarkCakeWidget({
    super.key,
    required this.cakeData,
  });

  // void onTapLikes(bool initialLike, WidgetRef ref) async {
  //   print('좋아요 버튼 클릭');
  //   if (ref.read(cakeProvider(cakeData.id)) == null) {
  //     ref.read(cakeProvider(cakeData.id).notifier).init(initialLike);
  //   }
  //   ref.read(cakeProvider(cakeData.id).notifier).toggleLike(
  //       /*widget.storeData*/);
  //   return;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // 케이크 클릭 이벤트 로깅
        ref.read(analyticsProvider).gaEvent('click_cake', {
          'cake_id': cakeData.id,
          'cake_store_id': cakeData.ownerStoreId,
        });
        // print('케이크 상세보기 페이지로 이동');
        context.push("/detail_cake/${cakeData.id}/${cakeData.ownerStoreId}");
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadow01],
            ),
            child: Image.network(
              cakeData.image.s3Url.replaceFirst("https", "http"),
              fit: BoxFit.cover,
            ),
          ),
          LikeButton(cakeData: cakeData),
        ],
      ),
    );
  }
}

class LikeButton extends ConsumerWidget {
  const LikeButton({
    super.key,
    required this.cakeData,
  });

  final Cake cakeData;

  void onTapLikes(bool initialLike, WidgetRef ref) async {
    print('좋아요 버튼 클릭');
    if (ref.read(cakeProvider(cakeData.id)) == null) {
      ref.read(cakeProvider(cakeData.id).notifier).init(initialLike);
    }
    ref.read(cakeProvider(cakeData.id).notifier).toggleLike(
        /*widget.storeData*/);
    return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => onTapLikes(cakeData.isLiked, ref),
          child: Stack(children: [
            ref.watch(cakeProvider(cakeData.id)) ?? cakeData.isLiked
                ? SvgPicture.asset('assets/icons/like=on_in.svg')
                : SvgPicture.asset('assets/icons/like=off_in.svg'),
            SvgPicture.asset('assets/icons/like=off.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcATop,
                )),
          ]),
        ));
  }
}
