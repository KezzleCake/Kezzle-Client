import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/toast.dart';
import 'package:kezzle/view_models/cake_vm.dart';
import 'package:kezzle/widgets/store_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailCakeScreen extends ConsumerWidget {
  static const routeName = 'detail_cake';
  final String cakeId;
  final String storeId;

  const DetailCakeScreen(
      {super.key, required this.cakeId, required this.storeId});

  void onTapOrderBtn(BuildContext context, String kakaoURL, String instaURL,
      WidgetRef ref, String storeName) {
    ref.read(analyticsProvider).gaEvent('click_order', {
      'cake_id': cakeId,
      'cake_store_id': storeId,
      'store_name': storeName,
    });
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )),
              height: 175,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(children: [
                  const SizedBox(height: 25),
                  ListTile(
                      onTap: () async {
                        // 카카오 채널 이동했는지 로깅
                        ref
                            .read(analyticsProvider)
                            .gaEvent('click_order_kakao', {
                          'cake_id': cakeId,
                          'cake_store_id': storeId,
                          'store_name': storeName,
                        });
                        if (kakaoURL.isNotEmpty) {
                          await launchUrlString(kakaoURL,
                              mode: LaunchMode.externalApplication);
                        } else {
                          Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                        }
                      },
                      leading: const FaIcon(FontAwesomeIcons.comment),
                      title: Text('스토어 카카오 채널로 이동',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray08))),
                  ListTile(
                      onTap: () async {
                        // 인스타그램 이동했는지 로깅
                        ref
                            .read(analyticsProvider)
                            .gaEvent('click_order_insta', {
                          'cake_id': cakeId,
                          'cake_store_id': storeId,
                          'store_name': storeName,
                        });
                        if (instaURL.isNotEmpty) {
                          await launchUrlString(instaURL,
                              mode: LaunchMode.externalApplication);
                        } else {
                          Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                        }
                      },
                      leading: const FaIcon(
                        FontAwesomeIcons.instagram,
                      ),
                      title: Text('스토어 인스타그램으로 이동',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray08))),
                ]),
              ));
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ga 이벤트 확인
    // ref.read(analyticsProvider).gaScreen(routeName);

    Future<Cake?> fetchCake() async {
      //케이크 정보 가져오기
      final response = await ref.read(cakesRepo).fetchCakeById(cakeId: cakeId);
      if (response != null) {
        // print(response);
        // response를 Cake로 변환
        final fetched = Cake.fromJson(response);
        // print(fetched);
        return fetched;
      }
      return null;
    }

    Future<DetailStoreModel?> fetchStore() async {
      //스토어 정보 가져오기
      // final double lat = ref.watch(searchSettingViewModelProvider).latitude;
      // final double lng = ref.watch(searchSettingViewModelProvider).longitude;
      final response = await ref.read(storeRepo).fetchDetailStore(
            storeId: storeId, /*lat: lat, lng: lng*/
          );
      if (response != null) {
        // print(response);
        // response를 DetailStoreModel로 변환
        final fetched = DetailStoreModel.fromJson(response);
        // print(fetched);
        return fetched;
      }
      return null;
    }

    Future<List<Cake>?> fetchAnoterCake() async {
      //스토어의 다른 케이크 가져오기
      final response =
          await ref.read(cakesRepo).fetchAnotherStoreCakes(storeId: storeId);

      if (response != null) {
        final fetched = response.map((e) => Cake.fromJson(e)).toList();
        return fetched;
      }
      return null;
    }

    // void onTapLikes(bool initialLike) async {
    //   print('좋아요 버튼 클릭');
    //   if (ref.read(cakeProvider(cakeId)) == null) {
    //     ref.read(cakeProvider(cakeId).notifier).init(initialLike);
    //   }
    //   ref.read(cakeProvider(cakeId).notifier).toggleLike(/*widget.storeData*/);
    //   return;
    // }

    return FutureBuilder<List<dynamic>>(
        future: Future.wait([fetchCake(), fetchStore(), fetchAnoterCake()]),
        builder: (context, data) {
          if (data.hasData) {
            final Cake cakeData = data.data![0]!;
            final DetailStoreModel storeData = data.data![1]!;
            final List<Cake> anotherCakeList = data.data![2]!;

            return Scaffold(
                // backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text(
                    '케이크 상세보기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    // 케이크 별로 상태관리 해줘야됨....
                    LikeButton(cakeData: cakeData),
                    // 클립보드 복사 아이콘
                    FaIcon(FontAwesomeIcons.download, size: 20, color: gray08),
                    FaIcon(FontAwesomeIcons.paperclip, size: 20, color: gray08),
                  ],
                ),
                body: SingleChildScrollView(
                    // 바운스 되는 게 낫나?
                    // physics: ClampingScrollPhysics(),
                    child: Column(children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        data.data![0].image.s3Url.replaceFirst("https", "http"),
                        fit: BoxFit.cover,
                      ),
                      // Image(
                      //   image: AssetImage('assets/heart_cake.png'),
                      //   height: 390,
                      // ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '스토어',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: gray08,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            StoreWidget(
                              storeData: data.data![1]!,
                            ),
                            const SizedBox(height: 40),
                            Row(children: [
                              Text('해당 스토어의 다른 케이크',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: gray08)),
                              const SizedBox(width: 6),
                            ]),
                            const SizedBox(height: 16),
                            SizedBox(
                                height: (MediaQuery.of(context).size.width -
                                        40 -
                                        6 * 3) /
                                    4,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: data.data![2]!.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 6),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            // print('케이크 상세보기 페이지로 이동');
                                            // context.push(
                                            //     "/detail_cake/${anotherCakeList[index].id}/${anotherCakeList[index].ownerStoreId}");
                                            // TODO: 네비게이트 방식으로 바꾸기
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchSimilarCakeScreen(
                                                            originalCake:
                                                                anotherCakeList[
                                                                    index])));
                                          },
                                          child: Container(
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40 -
                                                      6 * 3) /
                                                  4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  boxShadow: [shadow01]),
                                              clipBehavior: Clip.hardEdge,
                                              child: Image.network(
                                                  data.data![2]![index].image
                                                      .s3Url
                                                      .replaceFirst(
                                                          "https", "http"),
                                                  fit: BoxFit.cover)));
                                    })),
                            const SizedBox(height: 40),
                          ])),
                  // const SizedBox(height: 70),
                ])),
                bottomNavigationBar: BottomAppBar(
                    color: Colors.transparent,
                    elevation: 0,
                    child: GestureDetector(
                      onTap: () => onTapOrderBtn(context, storeData.kakaoURL!,
                          storeData.instaURL!, ref, storeData.name),
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: coral01,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text('주문하러 가기',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: gray01))),
                    )));
          } else if (data.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(child: CircularProgressIndicator(color: coral01)));
          } else {
            return const Scaffold(body: Center(child: Text('오류가 발생했습니다.')));
          }
        });
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
    return GestureDetector(
      onTap: () => onTapLikes(cakeData.isLiked!, ref),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          ref.watch(cakeProvider(cakeData.id)) ?? cakeData.isLiked!
              ? 'assets/icons/like=on_in.svg'
              : 'assets/icons/like=off_in.svg',
          width: 30,
        ),
      ),
    );
  }
}
