import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/my_divider_widget.dart';
import 'package:photo_view/photo_view.dart';

class IntroduceStore extends StatefulWidget {
  final DetailStoreModel store;
  const IntroduceStore({super.key, required this.store});

  @override
  State<IntroduceStore> createState() => _IntroduceStoreState();
}

class _IntroduceStoreState extends State<IntroduceStore> {
  final scrollController = ScrollController();
  // final List<String> imageURLs = [
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  // ];

  final List<String> day = ['월 ', '화 ', '수 ', '목 ', '금 ', '토 ', '일 '];

  final double horizontalPadding = 18;

  void onTapImage(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullScreenImage(
                  // imageURLs: imageURLs,
                  imageURLs:
                      widget.store.detailImages!.map((e) => e.s3Url).toList(),
                  initialIndex: index,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      widget.store.detailImages == null || widget.store.detailImages!.isEmpty
          ? const SizedBox(height: 16)
          : const SizedBox(height: 30),
      widget.store.detailImages == null || widget.store.detailImages!.isEmpty
          ? const SizedBox()
          : Scrollbar(
              controller: scrollController,
              child: SizedBox(
                  height: 168,
                  child: ListView.separated(
                      controller: scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.store.detailImages != null
                          ? widget.store.detailImages!.length
                          : 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            onTapImage(index);
                          },
                          child: Hero(
                            tag: 'image$index',
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                  imageUrl: widget
                                      .store.detailImages![index].s3Url
                                      .replaceFirst("https", "http"),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        );
                      }))),
      const SizedBox(height: 16),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(widget.store.storeDescription!,
              style: TextStyle(
                  fontSize: 12, color: gray07, fontWeight: FontWeight.w400))),
      MyDivider(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('영업 정보',
                style: TextStyle(
                    fontSize: 16, color: gray08, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: gray02),
                child: Row(children: [
                  const SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('픽업시간',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),

                        for (int i = 0;
                            i < widget.store.operatingTime!.length;
                            i++)
                          widget.store.operatingTime![i].isEmpty
                              ? Text('${day[i]} 휴무일',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: gray05,
                                      fontWeight: FontWeight.w600))
                              : Text(
                                  '${day[i]} ${widget.store.operatingTime![i]}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: gray05,
                                      fontWeight: FontWeight.w600)),
                        // Text(
                        //     // widget.store.operatingTime.join('\n'),
                        //     widget.store.operatingTime != null &&
                        //             widget.store.operatingTime!.isNotEmpty
                        //         ? widget.store.operatingTime!.join('\n')
                        //         : '픽업시간 정보가 없습니다.',
                        //     overflow: TextOverflow.ellipsis,
                        //     style: TextStyle(
                        //         fontSize: 12,
                        //         color: gray05,
                        //         fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text('전화번호',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(
                            // widget.store.phoneNumber,
                            widget.store.phoneNumber != null
                                ? widget.store.phoneNumber!
                                : '전화번호 정보가 없습니다.',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray05,
                                fontWeight: FontWeight.w600)),
                      ]),
                ])),
          ])),
      // const MyDivider(),
      // Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20),
      //     child:
      //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //       Text('가계 통계',
      //           style: TextStyle(
      //               fontSize: 16, color: gray08, fontWeight: FontWeight.w600)),
      //       const SizedBox(height: 16),
      //       Container(
      //           padding: const EdgeInsets.all(16),
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(16), color: gray02),
      //           child: Row(children: [
      //             Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('최근 주문 수',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray07,
      //                           fontWeight: FontWeight.w600)),
      //                   const SizedBox(height: 6),
      //                   Text('전체 주문 수',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray07,
      //                           fontWeight: FontWeight.w600)),
      //                 ]),
      //             const SizedBox(width: 35),
      //             Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('1,000',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray05,
      //                           fontWeight: FontWeight.w600)),
      //                   const SizedBox(height: 6),
      //                   Text('40,000',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray05,
      //                           fontWeight: FontWeight.w600)),
      //                 ]),
      //           ])),
      //     ])),
      const SizedBox(height: 50),
    ]);
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String> imageURLs;
  final int initialIndex;

  const FullScreenImage(
      {super.key, required this.imageURLs, required this.initialIndex});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: widget.initialIndex);
    // _pageController.addListener(() {
    //   setState(() {
    //     _currentPage = _pageController.page!.toInt();
    //   });
    // });
    _currentPage = widget.initialIndex;
    // _pageController.addListener(() {
    //   //print(_pageController.page);
    //   if (_pageController.page != null) {
    //     setState(() {
    //       _currentPage = _pageController.page!.toInt();
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   leading: IconButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.white)),
        // ),
        body: SafeArea(
            child: Stack(children: [
          PageView.builder(
            itemCount: widget.imageURLs.length,
            onPageChanged: (value) => setState(() {
              _currentPage = value;
            }),
            // controller: PageController(initialPage: initialIndex),
            controller: _pageController,
            itemBuilder: (context, index) {
              return Hero(
                tag: 'image$index',
                child: PhotoView(
                    // imageProvider: AssetImage(widget.imageURLs[index]),
                    imageProvider: NetworkImage(
                        widget.imageURLs[index].replaceFirst("https", "http")),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2.0
                    // child: AspectRatio(
                    //   aspectRatio: 1,
                    //   child: Container(
                    //     color: Colors.black,
                    //     child: Image.asset(
                    //       imageURLs[index],
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                    ),
              );
            },
          ),
          Stack(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    const FaIcon(FontAwesomeIcons.xmark, color: Colors.white)),
            //현재 몇페이지에 있는지
            // Text(
            //     '${_pageController.page?.toInt()} / ${widget.imageURLs.length}',
            //     style: const TextStyle(color: Colors.white)),
            // // Text('}/${widget.imageURLs.length}'),

            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.center,
                  width: 48,
                  height: 48,
                  child: Text(
                      '${_currentPage + 1} / ${widget.imageURLs.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                )),
          ]),
        ])));
  }
}
