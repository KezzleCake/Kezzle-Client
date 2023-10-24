import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
// import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
import 'package:kezzle/models/home_store_model.dart';
// import 'package:kezzle/screens/store/detail_store_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/store_view_model.dart';
// Image 패키지 별칭 짓기

class StoreWidget1 extends ConsumerStatefulWidget {
  // bool liked = false;
  final HomeStoreModel storeData;

  const StoreWidget1({
    super.key,
    required this.storeData,
  });

  @override
  StoreWidget1State createState() => StoreWidget1State();
}

class StoreWidget1State extends ConsumerState<StoreWidget1> {
  @override
  void initState() {
    print(widget.storeData);
    super.initState();

    Future.delayed(Duration.zero, () {
      ref
          .read(storeProvider(widget.storeData.id).notifier)
          .init(widget.storeData.isLiked);
    });
  }

  void onTapLikes(bool initialLike, WidgetRef ref) async {
    if (ref.read(storeProvider(widget.storeData.id)) == null) {
      ref.read(storeProvider(widget.storeData.id).notifier).init(initialLike);
    }
    ref.read(storeProvider(widget.storeData.id).notifier).toggleLike(
        /*widget.storeData*/);
    // ref.read(storeProvider(widget.storeData.id).notifier).toggleLike(
    // /*widget.storeData*/);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('스토어 디테일로 이동');
        // 스토어 누르는지 체크
        ref.read(analyticsProvider).gaEvent('click_store', {
          'store_id': widget.storeData.id,
          'store_name': widget.storeData.name,
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return DetailStoreScreen(store: widget.storeData);
        // }));
        context.push("/detail_store/${widget.storeData.id}");
      },
      child: Container(
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadow01]),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: gray03, width: 1),
                  ),
                  child: CircleAvatar(
                    backgroundColor: coral04,
                    radius: 63 / 2,
                    foregroundImage: NetworkImage(widget.storeData.logo != null
                        ? widget.storeData.logo!.s3Url
                            .replaceFirst("https", "http")
                        : ''),
                    onForegroundImageError: (exception, stackTrace) =>
                        const SizedBox(),
                  ),
                ),
                // CircleAvatar(
                //     // foregroundImage: NetworkImage(widget.storeData.logo!.s3Url),
                //     foregroundImage: NetworkImage(widget.storeData.logo == null
                //         ? ''
                //         : widget.storeData.logo!.s3Url
                //             .replaceFirst("https", "http")),
                //     onForegroundImageError: (exception, stackTrace) {
                //       return;
                //     },
                //     // backgroundImage: AssetImage(widget.storeData.thumbnail),
                //     // backgroundImage: Image.network(widget.storeData.logo.s3Url),
                //     radius: 63 / 2),
                const SizedBox(width: 8),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.storeData.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: gray08)),
                            GestureDetector(
                              onTap: () =>
                                  onTapLikes(widget.storeData.isLiked, ref),
                              // child: SvgPicture.asset(
                              //     widget.storeData.like
                              //         ? 'assets/icons/like=on_in.svg'
                              //         : 'assets/icons/like=off_in.svg',
                              //     width: 24),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 8,
                                ),
                                child: SvgPicture.asset(
                                  ref.watch(storeProvider(
                                              widget.storeData.id)) ??
                                          widget.storeData.isLiked
                                      ? 'assets/icons/like=on_in.svg'
                                      : 'assets/icons/like=off_in.svg',
                                  // ref
                                  //     .watch(storeProvider(widget.storeData.id))
                                  //     .when(
                                  //       data: (data) {
                                  //         if (data == true) {
                                  //           return 'assets/icons/like=on_in.svg';
                                  //         } else {
                                  //           return 'assets/icons/like=off_in.svg';
                                  //         }
                                  //       },
                                  //       loading: () =>
                                  //           'assets/icons/like=off_in.svg',
                                  //       error: (err, stack) =>
                                  //           'assets/icons/like=off_in.svg',
                                  //     ),
                                ),
                              ),
                            ),
                          ]),
                      // const SizedBox(height: 1),
                      widget.storeData.distance == null
                          ? Text(widget.storeData.address,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05))
                          : Text(
                              '${(widget.storeData.distance! / 1000).toStringAsFixed(1)}kmㆍ${widget.storeData.address}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05)),
                      // Text(widget.storeData.address,
                      //     style: TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w400,
                      //         color: gray05)),
                    ])),
              ]),
            ),
            const SizedBox(height: 10),
            widget.storeData.cakes!.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 90 + 16,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      itemCount: widget.storeData.cakes!.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 6),
                      itemBuilder: (context, index) => Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.hardEdge,
                        child: CachedNetworkImage(
                            imageUrl: widget.storeData.cakes![index].image.s3Url
                                .replaceFirst("https", "http"),
                            fit: BoxFit.cover),
                        // NetworkImage(widget.storeData.cakes[index].image.s3Url)
                        //     as Widget,
                        // Image.asset('assets/heart_cake.png'),
                      ),
                    ),
                  ),
          ])),
    );
  }
  // Future<void> _init() {
  //   ref
  //       .read(storeProvider(widget.storeData.id).notifier)
  //       .init(widget.storeData.isLiked);
  //   return Future.value();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       // padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(16),
  //           boxShadow: [shadow01]),
  //       child: Column(children: [
  //         Padding(
  //           padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
  //           child: Row(children: [
  //             CircleAvatar(
  //                 // backgroundImage: AssetImage(widget.storeData.thumbnail),
  //                 backgroundImage: NetworkImage(widget.storeData.logo.s3Url),
  //                 radius: 63 / 2),
  //             const SizedBox(width: 8),
  //             Expanded(
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                   Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(widget.storeData.name,
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: gray08)),
  //                         FutureBuilder<void>(
  //                             future: _init(),
  //                             builder: (context, snapshot) {
  //                               return GestureDetector(
  //                                 onTap: onTapLikes,
  //                                 // child: SvgPicture.asset(
  //                                 //     widget.storeData.like
  //                                 //         ? 'assets/icons/like=on_in.svg'
  //                                 //         : 'assets/icons/like=off_in.svg',
  //                                 //     width: 24),
  //                                 child: SvgPicture.asset(
  //                                   ref
  //                                       .watch(
  //                                           storeProvider(widget.storeData.id))
  //                                       .when(
  //                                         data: (data) {
  //                                           if (data == true) {
  //                                             return 'assets/icons/like=on_in.svg';
  //                                           } else {
  //                                             return 'assets/icons/like=off_in.svg';
  //                                           }
  //                                         },
  //                                         loading: () =>
  //                                             'assets/icons/like=off_in.svg',
  //                                         error: (err, stack) =>
  //                                             'assets/icons/like=off_in.svg',
  //                                       ),
  //                                 ),
  //                               );
  //                             }),
  //                       ]),
  //                   const SizedBox(height: 1),
  //                   Text(
  //                       '${(widget.storeData.distance / 1000).toStringAsFixed(1)}kmㆍ${widget.storeData.address}',
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w400,
  //                           color: gray05)),
  //                 ])),
  //           ]),
  //         ),
  //         const SizedBox(height: 10),
  //         widget.storeData.cakes.isEmpty
  //             ? const SizedBox()
  //             : SizedBox(
  //                 height: 90 + 16,
  //                 child: ListView.separated(
  //                   padding:
  //                       const EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //                   itemCount: widget.storeData.cakes.length,
  //                   scrollDirection: Axis.horizontal,
  //                   separatorBuilder: (context, index) =>
  //                       const SizedBox(width: 6),
  //                   itemBuilder: (context, index) => Container(
  //                     width: 90,
  //                     height: 90,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(16)),
  //                     clipBehavior: Clip.hardEdge,
  //                     child: Image.network(
  //                         widget.storeData.cakes[index].image.s3Url,
  //                         fit: BoxFit.cover),
  //                     // NetworkImage(widget.storeData.cakes[index].image.s3Url)
  //                     //     as Widget,
  //                     // Image.asset('assets/heart_cake.png'),
  //                   ),
  //                 ),
  //               ),
  //       ]));
  // }
}
