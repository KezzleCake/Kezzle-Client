import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_cake_vm.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
// import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';
// import 'package:kezzle/widgets/store_widget.dart';
import 'package:kezzle/widgets/store_widget1.dart';
// import 'package:kezzle/features/store_search/search_store_screen.dart';

class BookmarkScreen extends StatelessWidget {
  final List<String> tabList = ['스토어', '디자인'];

  BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('찜')),
        body: SafeArea(
            child: DefaultTabController(
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
                              bottom: BorderSide(color: coral01, width: 2))),
                      tabs: [
                        Tab(text: tabList[0]),
                        Tab(text: tabList[1]),
                      ]),
                  const Flexible(
                      child: TabBarView(children: [
                    StoreBookmarkScreen(),
                    // NoItemScreen(text: "찜한 스토어가 없어요"),
                    CakeBookmarkScreen(),
                    // NoItemScreen(text: "찜한 디자인이 없어요"),
                  ])),
                ]))));
  }
}

class CakeBookmarkScreen extends ConsumerWidget {
  const CakeBookmarkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 위도 경도 변경되면 실행되는 리스너
    // ref.listen(searchSettingViewModelProvider, (previous, next) {
    //   if (previous!.latitude != next.latitude ||
    //       previous.longitude != next.longitude) {
    //     ref.read(bookmarkedCakeProvider.notifier).refresh();
    //   }
    // });

    return ref.watch(bookmarkedCakeProvider).when(
        loading: () => Center(
              child: CircularProgressIndicator(color: coral01),
            ),
        error: (error, stackTrace) => Center(
              child: Text('찜 목록 불러오기 실패, $error'),
            ),
        data: (cakes) {
          ref.listen(searchSettingViewModelProvider, (previous, next) {
            if (previous!.latitude != next.latitude ||
                previous.longitude != next.longitude) {
              ref.read(bookmarkedCakeProvider.notifier).refresh();
            }
          });
          if (cakes.isEmpty) {
            return const NoItemScreen(text: "찜한 디자인이 없어요");
          }
          return GridView.builder(
              itemCount: cakes.length,
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                return BookmarkCakeWidget(cakeData: cakes[index]);
                // Container(
                //   decoration:
                //       BoxDecoration(borderRadius: BorderRadius.circular(16)),
                //   clipBehavior: Clip.hardEdge,
                //   child: Stack(alignment: Alignment.bottomRight, children: [
                //     // Image.asset('assets/heart_cake.png', fit: BoxFit.cover),
                //     Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Stack(children: [
                //           cakes[index].isLiked
                //               ? SvgPicture.asset('assets/icons/like=on_in.svg',
                //                   colorFilter: ColorFilter.mode(
                //                       coral01, BlendMode.srcATop))
                //               : SvgPicture.asset('assets/icons/like=off.svg',
                //                   colorFilter: const ColorFilter.mode(
                //                       Colors.white, BlendMode.srcATop)),
                //           // SvgPicture.asset('assets/icons/like=on_in.svg',
                //           //     colorFilter:
                //           //         ColorFilter.mode(coral01, BlendMode.srcATop)),
                //           // SvgPicture.asset('assets/icons/like=off.svg',
                //           //     colorFilter: const ColorFilter.mode(
                //           //         Colors.white, BlendMode.srcATop)),
                //         ])),
                //   ]));
              });
        });

    // return GridView.builder(
    //     itemCount: 20,
    //     padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3,
    //         crossAxisSpacing: 6,
    //         mainAxisSpacing: 6,
    //         childAspectRatio: 1),
    //     itemBuilder: (context, index) => Container(
    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    //         clipBehavior: Clip.hardEdge,
    //         child: Stack(alignment: Alignment.bottomRight, children: [
    //           // Image.asset('assets/heart_cake.png', fit: BoxFit.cover),
    //           Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Stack(children: [
    //                 SvgPicture.asset('assets/icons/like=on_in.svg',
    //                     colorFilter:
    //                         ColorFilter.mode(coral01, BlendMode.srcATop)),
    //                 SvgPicture.asset('assets/icons/like=off.svg',
    //                     colorFilter: const ColorFilter.mode(
    //                         Colors.white, BlendMode.srcATop)),
    //               ])),
    //         ])));
  }
}

class StoreBookmarkScreen extends ConsumerWidget {
  const StoreBookmarkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 위도 경도 변경되면 실행되는 리스너
    // ref.listen(searchSettingViewModelProvider, (previous, next) {
    //   if (previous!.latitude != next.latitude ||
    //       previous.longitude != next.longitude) {
    //     ref.read(bookmarkedStoreProvider.notifier).refresh();
    //   }
    // });

    return ref.watch(bookmarkedStoreProvider).when(
        loading: () => Center(
              child: CircularProgressIndicator(color: coral01),
            ),
        error: (error, stackTrace) => Center(
              child: Text('찜 목록 불러오기 실패, $error'),
            ),
        data: (stores) {
          if (stores.isEmpty) {
            return const NoItemScreen(text: "찜한 스토어가 없어요");
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return StoreWidget1(storeData: store);
            },
          );
        });
  }
}

class NoItemScreen extends StatelessWidget {
  final String text;

  const NoItemScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
      SvgPicture.asset('assets/icons/illust-empty.svg'),
      const SizedBox(height: 15),
      Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: gray05)),
    ]);
  }
}
