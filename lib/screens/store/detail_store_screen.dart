import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/screens/store/introduce_store_tabview.dart';
import 'package:kezzle/screens/store/store_location_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/toast.dart';
import 'package:kezzle/view_models/store_cakes_vm.dart';
import 'package:kezzle/view_models/store_view_model.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';
import 'package:kezzle/widgets/url_launch_dialog_widget.dart';

final tabs = [
  // '가격',
  '케이크',
  '가게 소개',
  '상세 위치',
  // '리뷰',
];

class DetailStoreScreen extends ConsumerWidget {
  static const routeName = 'detail_store';
  final String storeId;

  const DetailStoreScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<DetailStoreModel?> fetchDetailStoreData() async {
      // final lat = ref.watch(searchSettingViewModelProvider).latitude;
      // final lng = ref.watch(searchSettingViewModelProvider).longitude;

      final response = await ref.read(storeRepo).fetchDetailStore(
            storeId: storeId, /* lat: lat, lng: lng*/
          );
      if (response != null) {
        final fetched = DetailStoreModel.fromJson(response);
        return fetched;
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('스토어'),
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
              // CircleAvatar(

              //   radius: 63 / 2,
              //   foregroundImage: NetworkImage(store.logo != null
              //       ? store.logo!.s3Url.replaceFirst("https", "http")
              //       : ''),
              //   onForegroundImageError: (exception, stackTrace) =>
              //       const SizedBox(),
              // ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: gray03, width: 1),
                ),
                child: CircleAvatar(
                  radius: 63 / 2,
                  foregroundImage: NetworkImage(store.logo != null
                      ? store.logo!.s3Url.replaceFirst("https", "http")
                      : ''),
                  onForegroundImageError: (exception, stackTrace) =>
                      const SizedBox(),
                ),
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
                    // const SizedBox(height: 16),
                    Row(children: [
                      GestureDetector(
                          onTap: () async {
                            // print(store.instaURL);
                            if (store.instaURL != null &&
                                store.instaURL!.isNotEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => LaunchExternalURLDialog(
                                        title: '스토어의 인스타그램으로\n이동하시겠습니까?',
                                        content:
                                            '더 다양한 스토어의 정보를 확인해보실 수 있습니다. 주문은 원하는 케이크 이미지를 저장/복사 후, 카톡으로 전달하여 주문하세요!',
                                        url: store.instaURL!,
                                      ));
                              // await launchUrlString(store.instaURL!,
                              //     mode: LaunchMode.externalApplication);
                            } else {
                              Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                right: 13 / 2,
                                bottom: 5,
                                top: 16,
                                // left: 5,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/insta.svg',
                                width: 24,
                              ))),
                      // const SizedBox(width: 13),
                      GestureDetector(
                        onTap: () async {
                          if (store.kakaoURL != null &&
                              store.kakaoURL!.isNotEmpty) {
                            // 팝업창으로 묻고 이동시키기
                            showDialog(
                                context: context,
                                builder: (context) => LaunchExternalURLDialog(
                                      title: '스토어의 카카오톡 채널로\n이동하시겠습니까?',
                                      content:
                                          '먼저 원하는 케이크 이미지를 복사/저장한 후, 카톡으로 전달하여 주문을 완료해보세요!',
                                      url: store.kakaoURL!,
                                    ));
                            // await launchUrlString(store.kakaoURL!,
                            //     mode: LaunchMode.externalApplication);
                          } else {
                            Toast.toast(context, '해당 링크가 존재하지 않습니다. 😅');
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 13 / 2,
                            bottom: 5,
                            top: 16,
                            // left: 5,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.solidComment,
                            size: 24,
                          ),
                        ),
                      ),
                    ]),
                  ])),
              GestureDetector(
                onTap: () {
                  // if (ref.read(storeProvider(storeId) == null)) {
                  // ref.read(storeProvider(storeId).notifier).init(initialLike);
                  // }
                  if (ref.read(storeProvider(storeId)) == null) {
                    ref
                        .read(storeProvider(storeId).notifier)
                        .init(store.isLiked);
                  }

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
  bool isLoading = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() async {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔으면 새로운 데이터 추가요청

    if (controller.offset > controller.position.maxScrollExtent - 300 &&
        !isLoading &&
        ref
                .read(storeCakesViewModelProvider(widget.storeId).notifier)
                .fetchMore ==
            true) {
      print('fetchMore');
      setState(() {
        isLoading = true;
      });
      await ref
          .read(storeCakesViewModelProvider(widget.storeId).notifier)
          .fetchNextPage();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(storeCakesViewModelProvider(widget.storeId)).when(
      data: (cakes) {
        return Column(children: [
          Flexible(
              child: GridView.builder(
            controller: controller,
            itemCount: cakes.length + (isLoading ? 3 : 0),
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
            itemBuilder: (context, index) {
              // print(index);
              if (index == cakes.length && isLoading) {
                return Container();
              } else if (index == cakes.length + 1 && isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (index == cakes.length + 2 && isLoading) {
                return Container();
              } else if (index != cakes.length) {
                return BookmarkCakeWidget(cakeData: cakes[index]);
              }
            },
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
  }
}
