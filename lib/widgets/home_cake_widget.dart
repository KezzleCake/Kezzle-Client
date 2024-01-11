import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/profile/view_models/profile_vm.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/toast.dart';

class HomeCakeWidget extends ConsumerWidget {
  final Cake cakeData;
  double? circular;

  HomeCakeWidget({
    super.key,
    required this.cakeData,
    this.circular = 16,
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
        context.pushNamed(SearchSimilarCakeScreen.routeName, extra: cakeData);
        // print('케이크 상세보기 페이지로 이동');
        // context.push("/detail_cake/${cakeData.id}/${cakeData.ownerStoreId}");
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circular!),
            boxShadow: [shadow01]),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                  imageUrl: cakeData.image.s3Url.replaceFirst("https", "http"),
                  fit: BoxFit.cover),
            ),
            if (ref.read(profileProvider.notifier).isAdmin)
              Positioned(
                top: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    bool success = await ref
                        .read(cakesRepo)
                        .deleteCake(cakeId: cakeData.id);
                    if (success) {
                      if (!context.mounted) return;
                      Toast.toast(context, '삭제 성공');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.5, vertical: 12),
                    child:
                        FaIcon(FontAwesomeIcons.trash, size: 20, color: gray01),
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
