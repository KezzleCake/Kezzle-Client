import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/screens/store/introduce_store_tabview.dart';
import 'package:kezzle/screens/store/store_location_screen.dart';
// import 'package:kezzle/screens/store/store_price_tabview.dart';
// import 'package:kezzle/screens/store/store_review_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/toast.dart';
// import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/view_models/store_cakes_vm.dart';
import 'package:kezzle/view_models/store_view_model.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

final tabs = [
  // '가격',
  '케이크',
  '가게 소개',
  '상세 위치',
  // '리뷰',
];

class DetailStoreScreen extends ConsumerWidget {
  // static const routeURL = '/detail_store';
  static const routeName = 'detail_store';
  final String storeId;
  // final HomeStoreModel store;

  const DetailStoreScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<DetailStoreModel?> fetchDetailStoreData() async {
      // final String token = await ref.read(tokenProvider.notifier).getIdToken();
      final lat = ref.watch(searchSettingViewModelProvider).latitude;
      final lng = ref.watch(searchSettingViewModelProvider).longitude;

      final response = await ref
          .read(storeRepo)
          .fetchDetailStore(storeId: storeId, lat: lat, lng: lng);
      if (response != null) {
        // print(response);
        // response를 DetailStoreModel로 변환
        final fetched = DetailStoreModel.fromJson(response);
        // print(fetched);
        return fetched;
      }
      return null;
    }

    // Future<List<Cake>?> fetchCakesData() async {
    //   // final String token = await ref.read(tokenProvider.notifier).getIdToken();
    //   final response =
    //       await ref.read(cakesRepo).fetchCakesByStoreId(storeId: storeId);
    //   if (response != null) {
    //     // response를 Cake로 변환
    //     final fetched = response.map((e) => Cake.fromJson(e)).toList();
    //     // print(fetched);
    //     return fetched;
    //   }
    //   return null;
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text('스토어'),
          // actions: [
          //   // IconButton(
          //   //   onPressed: () {},
          //   //   icon: SvgPicture.asset('assets/icons/share.svg'),
          //   // ),
          // ],
        ),
        body: DefaultTabController(
            length: tabs.length,
            child: FutureBuilder<List<dynamic>>(
                future: Future.wait([
                  fetchDetailStoreData(), /*fetchCakesData()*/
                ]),
                builder: (context, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(color: coral01));
                  } else if (data.hasData) {
                    return Column(children: [
                      _defaultStoreInfo(data.data![0] as DetailStoreModel),
                      _tabBar(),
                      Expanded(
                          child: _tabBarView(
                        data.data![0]
                            as DetailStoreModel, /*data.data![1] as List<Cake>*/
                      )),
                    ]);
                  } else {
                    return const Center(child: Text('데이터를 불러오는데 실패했습니다.'));
                  }
                })));
  }

  Widget _tabBar() => TabBar(
      splashFactory: NoSplash.splashFactory,
      labelColor: coral01,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      unselectedLabelColor: gray05,
      unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: coral01, width: 2))),
      tabs: [for (var tab in tabs) Tab(text: tab)]);

  Widget _tabBarView(DetailStoreModel store /*, List<Cake> cakes*/) =>
      TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        // const StorePrice(),
        // StoreCakes(cakes: cakes),
        StoreCakes(storeId: storeId),
        IntroduceStore(store: store),
        StoreLocation(store: store),
        // StoreReview(),
      ]);

  ConsumerWidget _defaultStoreInfo(DetailStoreModel store) {
    final likeCntProvider = StateProvider<int>((ref) => store.likeCnt);
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                radius: 63 / 2,
                foregroundImage:
                    NetworkImage(store.logo != null ? store.logo!.s3Url : ''),
                onForegroundImageError: (exception, stackTrace) =>
                    const SizedBox(),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(store.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: gray08,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 3),
                    // Row(children: [
                    //   FaIcon(FontAwesomeIcons.solidStar, size: 14, color: orange01),
                    //   const SizedBox(width: 3),
                    //   Text('4.5(100+)',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: gray07,
                    //         fontWeight: FontWeight.w600,
                    //       )),
                    // ]),
                    const SizedBox(height: 8),
                    if (store.storeFeature != null &&
                        store.storeFeature!.isNotEmpty) ...[
                      Text(
                          store.storeFeature == null ? '' : store.storeFeature!,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 12,
                              color: gray06,
                              fontWeight: FontWeight.w400)),
                    ],
                    const SizedBox(height: 16),
                    Row(children: [
                      GestureDetector(
                        onTap: () async {
                          // print(store.instaURL);
                          if (store.instaURL != null &&
                              store.instaURL!.isNotEmpty) {
                            await launchUrlString(store.instaURL!,
                                mode: LaunchMode.externalApplication);
                          } else {
                            Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                          }
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.instagram,
                        ),
                      ),
                      const SizedBox(width: 13),
                      GestureDetector(
                        onTap: () async {
                          if (store.kakaoURL != null &&
                              store.kakaoURL!.isNotEmpty) {
                            await launchUrlString(store.kakaoURL!,
                                mode: LaunchMode.externalApplication);
                          } else {
                            Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                          }
                        },
                        child: const FaIcon(FontAwesomeIcons.comment),
                      ),
                    ]),
                  ])),
              GestureDetector(
                onTap: () {
                  // if (ref.read(storeProvider(storeId) == null)) {
                  // ref.read(storeProvider(storeId).notifier).init(initialLike);
                  // }

                  ref.watch(storeProvider(store.id)) == true
                      ? ref.read(likeCntProvider.notifier).state -= 1
                      : ref.read(likeCntProvider.notifier).state += 1;
                  // ref.read(storeProvider(store.id)).whenData((value) {
                  //   if (value == true) {
                  //     ref.read(likeCntProvider.notifier).state -= 1;
                  //     // ref
                  //     //     .read(likeCntProvider.notifier)
                  //     //     .update((state) => state - 1);
                  //   } else {
                  //     ref.read(likeCntProvider.notifier).state += 1;
                  //     // ref
                  //     //     .read(likeCntProvider.notifier)
                  //     //     .update((state) => state + 1);
                  //   }
                  // });
                  ref.read(storeProvider(store.id).notifier).toggleLike();
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(children: [
                      SvgPicture.asset(
                        ref.watch(storeProvider(store.id)) ?? store.isLiked
                            ? 'assets/icons/like=on.svg'
                            : 'assets/icons/like=off.svg',

                        // ref.watch(storeProvider(store.id)).when(
                        //     data: (data) => data == true
                        //         ? 'assets/icons/like=on.svg'
                        //         : 'assets/icons/like=off.svg',
                        //     loading: () => 'assets/icons/like=off.svg',
                        //     error: (e, s) => 'assets/icons/like=off.svg'),
                      ),
                      Text(ref.watch(likeCntProvider).toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: coral01,
                              fontWeight: FontWeight.w600)),
                    ])),
              ),
            ]));
      },
    );
  }
}

class StoreCakes extends ConsumerStatefulWidget {
  final String storeId;
  // final List<Cake> cakes;
  const StoreCakes({super.key, required this.storeId});

  @override
  ConsumerState<StoreCakes> createState() => _StoreCakesState();
}

class _StoreCakesState extends ConsumerState<StoreCakes> {
  // bool isLike = false;
  // int selectedKeywordIndex = 0;
  // final List<String> keywords = [
  //   '전체',
  //   '생일',
  //   '커플',
  //   '아이',
  //   '기념일',
  //   '기타',
  //   '곰돌이',
  //   '레터링',
  //   '꽃',
  // ];

  //버튼 누르면 선택된 인덱스를 바꾸는 함수
  // void onTapKeyword(int index) {
  //   setState(() {
  //     selectedKeywordIndex = index;
  //   });
  // }

  // void onTapLike() {
  //   setState(() {
  //     isLike = !isLike;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ref.watch(storeCakesViewModelProvider(widget.storeId)).when(
      data: (cakes) {
        return Column(children: [
          Flexible(
              child: GridView.builder(
            itemCount: cakes.length,
            padding: const EdgeInsets.only(
              top: 16,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) =>
                BookmarkCakeWidget(cakeData: cakes[index]),
          )),
        ]);
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (e, s) {
        return Center(child: Text('$e'));
      },
    );

    // return Column(children: [
    //   // const SizedBox(height: 30),
    //   // SizedBox(
    //   //     height: 30,
    //   //     child: ListView.separated(
    //   //         itemCount: keywords.length,
    //   //         padding: const EdgeInsets.symmetric(horizontal: 20),
    //   //         scrollDirection: Axis.horizontal,
    //   //         separatorBuilder: (context, index) => const SizedBox(width: 8),
    //   //         itemBuilder: (context, index) => GestureDetector(
    //   //               //누르면 선택된 인덱스를 바꾸는 함수
    //   //               onTap: () => onTapKeyword(index),
    //   //               child: AnimatedContainer(
    //   //                   duration: const Duration(milliseconds: 100),
    //   //                   alignment: Alignment.center,
    //   //                   padding: const EdgeInsets.symmetric(
    //   //                       vertical: 4, horizontal: 10),
    //   //                   decoration: BoxDecoration(
    //   //                       borderRadius: BorderRadius.circular(16),
    //   //                       color: index == selectedKeywordIndex
    //   //                           ? coral01
    //   //                           : coral04),
    //   //                   child: Text(keywords[index],
    //   //                       style: TextStyle(
    //   //                           fontSize: 14,
    //   //                           color: index == selectedKeywordIndex
    //   //                               ? Colors.white
    //   //                               : coral01,
    //   //                           fontWeight: FontWeight.w600))),
    //   //             ))),
    //   // const SizedBox(height: 16),
    //   Flexible(
    //       child: GridView.builder(
    //     itemCount: widget.cakes.length,
    //     padding: const EdgeInsets.only(
    //       top: 16,
    //       left: 20,
    //       right: 20,
    //       bottom: 40,
    //     ),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 3,
    //       crossAxisSpacing: 6,
    //       mainAxisSpacing: 6,
    //       childAspectRatio: 1,
    //     ),
    //     itemBuilder: (context, index) =>
    //         BookmarkCakeWidget(cakeData: widget.cakes[index]),
    //   )),
    // ]);
  }
}
