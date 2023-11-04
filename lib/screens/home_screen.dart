import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/bookmark/bookmark_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/home_cake_view_model.dart';
import 'package:kezzle/view_models/home_store_view_model.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/widgets/distance_setting_widget.dart';
import 'package:kezzle/widgets/home_cake_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';
import 'package:kezzle/widgets/store_widget1.dart';

class SearchAroundScreen extends ConsumerStatefulWidget {
  const SearchAroundScreen({super.key});

  @override
  SearchAroundScreenState createState() => SearchAroundScreenState();
}

class SearchAroundScreenState extends ConsumerState<SearchAroundScreen>
    with SingleTickerProviderStateMixin {
  final List<String> tabList = ['스토어 모아보기', '케이크 모아보기'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTapLocation(BuildContext context) {
    // 위치 설정 버튼 누르는지 체크
    ref.read(analyticsProvider).gaEvent('btn_location_setting', {
      // 현재 어떤 화면인지 알려주기 위해 location에 현재 화면 이름 넣어줌.
      'screen_location': 'SearchAroundScreen',
    });

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // return const CalendarWidget();
          return const LocationSettingWidget();
        });
  }

  void _onTapDistance(BuildContext context) {
    showModalBottomSheet<int>(
        context: context,
        builder: (context) {
          return DistanceSettingWidget(
              initialValue: ref.watch(searchSettingViewModelProvider).radius);
        });
    ref.read(analyticsProvider).gaEvent('btn_distance_setting', {
      // 현재 어떤 화면인지 알려주기 위해 location에 현재 화면 이름 넣어줌.
      'screen_location': 'SearchAroundScreen',
      'distance': ref.watch(searchSettingViewModelProvider).radius,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Row(children: [
            const SizedBox(width: 10),
            InkWell(
                highlightColor: Colors.transparent, // 눌린 상태에서 물결 효과 비활성화
                splashColor: Colors.transparent,
                onTap: () {
                  _onTapLocation(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(children: [
                    Text(
                        ref
                                .watch(searchSettingViewModelProvider)
                                .address
                                .isEmpty
                            ? '위치를 설정해주세요'
                            : ref
                                        .watch(searchSettingViewModelProvider)
                                        .address
                                        .length >
                                    20
                                ? '${ref.watch(searchSettingViewModelProvider).address.substring(0, 18)}...'
                                : ref
                                    .watch(searchSettingViewModelProvider)
                                    .address,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray08)),
                    Padding(
                      padding: Platform.isAndroid
                          ? const EdgeInsets.only(top: 2.0)
                          : const EdgeInsets.all(0),
                      child: SvgPicture.asset('assets/icons/arrow-down.svg',
                          colorFilter:
                              ColorFilter.mode(gray07, BlendMode.srcIn)),
                    )
                  ]),
                )),
            InkWell(
                highlightColor: Colors.transparent, // 눌린 상태에서 물결 효과 비활성화
                splashColor: Colors.transparent,
                onTap: () => _onTapDistance(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: Platform.isAndroid
                              ? const EdgeInsets.only(top: 2.0)
                              : const EdgeInsets.all(0),
                          child: Text(
                              '${ref.watch(searchSettingViewModelProvider).radius}km',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: Platform.isAndroid
                              ? const EdgeInsets.only(top: 2.0)
                              : const EdgeInsets.all(0),
                          child: SvgPicture.asset('assets/icons/arrow-down.svg',
                              colorFilter:
                                  ColorFilter.mode(gray07, BlendMode.srcIn)),
                        ),
                      ]),
                )),
          ]),
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(children: [
              TabBar(
                  splashFactory: NoSplash.splashFactory,
                  labelColor: coral01,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  unselectedLabelColor: gray05,
                  indicator: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: coral01, width: 2),
                  )),
                  tabs: [
                    Tab(text: tabList[0]),
                    Tab(text: tabList[1]),
                  ]),
              const Flexible(
                  child: TabBarView(children: [
                StoreTabBarView(),
                //디자인 모아보기 탭 화면
                CakeTabBarView(),
              ])),
            ])),
      ),
    ]);
  }
}

class CakeTabBarView extends ConsumerStatefulWidget {
  const CakeTabBarView({
    super.key,
  });

  @override
  CakeTabBarViewState createState() => CakeTabBarViewState();
}

class CakeTabBarViewState extends ConsumerState<CakeTabBarView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
        ref.read(homeCakeProvider.notifier).fetchMore == true) {
      print('fetchMore');
      setState(() {
        isLoading = true;
      });
      await ref.read(homeCakeProvider.notifier).fetchNextPage();
      setState(() {
        isLoading = false;
      });
    } else {
      return;
    }
  }

  Future<void> onRefresh() async {
    // 위도 경도, 리프레시 일어나면 실행되게.
    // await Future.delayed(const Duration(seconds: 1));
    return ref.read(homeCakeProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 반경이나, 위도 경도 변경되면 실행되는 리스너
    ref.listen(searchSettingViewModelProvider, (previous, next) {
      if (previous != next) {
        ref.read(homeCakeProvider.notifier).refresh();
      }
    });

    return ref.watch(homeCakeProvider).when(
        loading: () => Center(child: CircularProgressIndicator(color: coral01)),
        error: (error, stackTrace) =>
            Center(child: Text('케이크 목록 불러오기 실패, $error')),
        data: (cakes) {
          return cakes.isEmpty
              ? const NoItemScreen(
                  text: "설정 위치 주변에 스토어가 없어요.\n반경을 넓히거나 위치를 변경해보세요!")
              : RefreshIndicator(
                  color: coral01,
                  onRefresh: onRefresh,
                  child: GridView.builder(
                      controller: controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 1),
                      itemCount: cakes.length + (isLoading ? 3 : 0),
                      itemBuilder: (context, index) {
                        if (index == cakes.length && isLoading) {
                          return Container();
                        } else if (index == cakes.length + 1 && isLoading) {
                          return Center(
                              child: CircularProgressIndicator(color: coral01));
                        } else if (index == cakes.length + 2 && isLoading) {
                          return Container();
                        } else if (index != cakes.length) {
                          final cakeData = cakes[index];
                          return HomeCakeWidget(cakeData: cakeData);
                        }
                        // } else {}
                      }),
                );
        });
  }
}

class StoreTabBarView extends ConsumerStatefulWidget {
  const StoreTabBarView({
    super.key,
  });

  @override
  StoreTabBarViewState createState() => StoreTabBarViewState();
}

class StoreTabBarViewState extends ConsumerState<StoreTabBarView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // int _storeCount = 0;
  // bool isMore = false;
  bool isLoading = false;

  // 스크롤 컨트롤러로 데이터 불러올 때 사용
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
        ref.read(homeStoreProvider.notifier).fetchMore == true) {
      print('fetchMore');
      setState(() {
        isLoading = true;
      });
      await ref.read(homeStoreProvider.notifier).fetchNextPage();
      setState(() {
        isLoading = false;
      });
    } else {
      return;
    }
  }

  Future<void> onRefresh() async {
    // await Future.delayed(const Duration(seconds: 1));
    return await ref.read(homeStoreProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // async니까 빌드베서드 끝나도록 기다려야됨. -> when 사용
    return ref.watch(homeStoreProvider).when(loading: () {
      return Center(child: CircularProgressIndicator(color: coral01));
      // return Container();
    }, error: (error, stackTrace) {
      // return Center(child: CircularProgressIndicator(color: coral01));
      return Center(child: Text('스토어 목록 불러오기 실패, $error'));
    }, data: (stores) {
      // _storeCount를 굳이 써야되나? stores.length만으로도 조건을 세울수 있을거같음.
      // _storeCount = stores.length;

      return stores.isEmpty
          ? const NoItemScreen(
              text: "설정 위치 주변에 스토어가 없어요.\n반경을 넓히거나 위치를 변경해보세요!")
          : NotificationListener<ScrollUpdateNotification>(
              // onNotification: (notification) {
              //   if (notification.metrics.pixels >
              //       notification.metrics.maxScrollExtent * 0.85) {
              //     // 다음 거 가져오는 조건?
              //     if (!isMore && _storeCount % 10 == 0) {
              //       fetchNextPage();
              //     }
              //   }
              //   return true;
              // },
              child: RefreshIndicator(
              color: coral01,
              backgroundColor: Colors.white,
              onRefresh: onRefresh,
              child: ListView.separated(
                  controller: controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  itemCount: stores.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == stores.length && isLoading) {
                      return Center(
                          child: CircularProgressIndicator(color: coral01));
                    } else if (index != stores.length) {
                      final storeData = stores[index];
                      return Column(children: [
                        StoreWidget1(storeData: storeData),
                      ]);
                    }
                  }),
            ));
    });
  }
}
