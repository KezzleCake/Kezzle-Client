import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/profile/view_models/profile_vm.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/toast.dart';
import 'package:kezzle/view_models/cake_vm.dart';
import 'package:kezzle/widgets/store_widget.dart';
import 'package:kezzle/widgets/url_launch_dialog_widget.dart';
import 'package:super_clipboard/super_clipboard.dart';

class DetailCakeScreen extends ConsumerStatefulWidget {
  static const routeName = 'detail_cake';

  final String cakeId;
  final String storeId;

  const DetailCakeScreen(
      {super.key, required this.cakeId, required this.storeId});

  @override
  ConsumerState<DetailCakeScreen> createState() => DetailCakeScreenState();
}

class DetailCakeScreenState extends ConsumerState<DetailCakeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onTapOrderBtn(BuildContext context, String kakaoURL, String instaURL,
      WidgetRef ref, String storeName) {
    ref.read(analyticsProvider).gaEvent('click_order', {
      'cake_id': widget.cakeId,
      'cake_store_id': widget.storeId,
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
                          'cake_id': widget.cakeId,
                          'cake_store_id': widget.storeId,
                          'store_name': storeName,
                        });
                        if (kakaoURL.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => LaunchExternalURLDialog(
                                    title: '스토어의 카카오톡 채널로\n이동하시겠습니까?',
                                    content:
                                        '먼저 우측 상단 아이콘을 통해 케이크 이미지를 복사/저장한 후, 카톡으로 전달하여 주문을 완료해보세요!',
                                    url: kakaoURL,
                                  ));
                          // await launchUrlString(kakaoURL,
                          //     mode: LaunchMode.externalApplication);
                        } else {
                          Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                        }
                      },
                      leading:
                          const FaIcon(FontAwesomeIcons.solidComment, size: 26),
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
                          'cake_id': widget.cakeId,
                          'cake_store_id': widget.storeId,
                          'store_name': storeName,
                        });
                        if (instaURL.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => LaunchExternalURLDialog(
                                    title: '스토어의 인스타그램으로\n이동하시겠습니까?',
                                    content:
                                        '더 다양한 스토어의 정보를 확인해보실 수 있습니다. 주문은 케이크 이미지를 저장/복사 후, 카톡으로 전달하여 주문하세요!',
                                    url: instaURL,
                                  ));
                          // await launchUrlString(instaURL,
                          //     mode: LaunchMode.externalApplication);
                        } else {
                          Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                        }
                      },
                      leading: SvgPicture.asset(
                        'assets/icons/insta.svg',
                        height: 26,
                      ),
                      // const FaIcon(
                      //   FontAwesomeIcons.instagram,
                      // ),
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
  Widget build(BuildContext context) {
    Future<Cake?> fetchCake() async {
      //케이크 정보 가져오기
      final response =
          await ref.read(cakesRepo).fetchCakeById(cakeId: widget.cakeId);
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
            storeId: widget.storeId, /*lat: lat, lng: lng*/
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
      final response = await ref
          .read(cakesRepo)
          .fetchAnotherStoreCakes(storeId: widget.storeId);

      if (response != null) {
        final fetched = response.map((e) => Cake.fromJson(e)).toList();
        return fetched;
      }
      return null;
    }

    saveNetworkImage(String imageUrl) async {
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      // print(result);
      return result['isSuccess'];
    }

    void onTapSaveBtn(String imageUrl) async {
      bool isSuccess = await saveNetworkImage(imageUrl);
      if (!context.mounted) return;
      if (isSuccess) {
        Toast.toast(context, '이미지가 저장되었습니다.');

        ref.read(analyticsProvider).gaEvent('save_cake_image', {
          'cake_id': widget.cakeId,
          'cake_store_id': widget.storeId,
        });
      } else {
        Toast.toast(context, '이미지 저장에 실패했습니다.');
      }
    }

    Future<Uint8List> createImageData(String imageUrl) async {
      final response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      return response.data;
    }

    void copyImage(String imageUrl) async {
      final image = await createImageData(imageUrl);
      final item = DataWriterItem(suggestedName: 'RedCircle.png');
      item.add(Formats.png(image));
      await ClipboardWriter.instance.write([item]);
      if (!context.mounted) return;
      Toast.toast(context, '이미지가 클립보드에 복사되었습니다.');

      ref.read(analyticsProvider).gaEvent('copy_cake_image', {
        'cake_id': widget.cakeId,
        'cake_store_id': widget.storeId,
      });
    }

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
                  title: const Text('케이크 상세보기',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  actions: [
                    // 케이크 별로 상태관리 해줘야됨....
                    if (ref.read(profileProvider.notifier).isAdmin)
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          bool success = await ref
                              .read(cakesRepo)
                              .deleteCake(cakeId: cakeData.id);
                          if (success) {
                            if (!mounted) return;
                            Toast.toast(context, '삭제 성공');
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7.5, vertical: 12),
                          child: FaIcon(FontAwesomeIcons.trash,
                              size: 20, color: gray08),
                        ),
                      ),
                    GestureDetector(
                        onTap: () => onTapSaveBtn(cakeData.image.s3Url),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.5, vertical: 12),
                            child: FaIcon(FontAwesomeIcons.download,
                                size: 20, color: gray08))),
                    GestureDetector(
                        onTap: () => copyImage(cakeData.image.s3Url),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.5, vertical: 12),
                            child: FaIcon(FontAwesomeIcons.paperclip,
                                size: 20, color: gray08))),
                    // ref.read(profileProvider).

                    LikeButton(cakeData: cakeData),
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
                      child: CachedNetworkImage(
                        imageUrl: data.data![0].image.s3Url
                            .replaceFirst("https", "http"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ]),
                            const SizedBox(height: 16),
                            StoreWidget(storeData: data.data![1]!),
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

                                            index == 3
                                                ? context.push(
                                                    "/detail_store/${storeData.id}")
                                                : context.pushNamed(
                                                    SearchSimilarCakeScreen
                                                        .routeName,
                                                    extra:
                                                        anotherCakeList[index]);
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
                                              child: Stack(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: CachedNetworkImage(
                                                        imageUrl: data
                                                            .data![2]![index]
                                                            .image
                                                            .s3Url
                                                            .replaceFirst(
                                                                "https",
                                                                "http"),
                                                        fit: BoxFit.cover),
                                                  ),
                                                  index == 3
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          color: const Color(
                                                                  0xff40414F)
                                                              .withOpacity(0.7),
                                                          child: Text('더보기+',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      gray01),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                        )
                                                      : Container(),
                                                ],
                                              )));
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
    //TODO: GA 추가
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
            padding: const EdgeInsets.only(
                right: 12.0, top: 12, bottom: 12, left: 4),
            child: SvgPicture.asset(
              ref.watch(cakeProvider(cakeData.id)) ?? cakeData.isLiked!
                  ? 'assets/icons/like=on_in.svg'
                  : 'assets/icons/like=off_in.svg',
              width: 30,
            )));
  }
}
