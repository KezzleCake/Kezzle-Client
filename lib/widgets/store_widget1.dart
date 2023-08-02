import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/store_view_model.dart';

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
  void onTapLikes() async {
    // 특정 스토어를 위한 프로바이더를 만들어줌
    // 이미 좋아요를 누른상태면 좋아요 취소
    // 좋아요 상태까지도 처음에 초기화 해줘야될거같음.
    if (widget.storeData.like) {
      await ref.read(storeProvider(widget.storeData.id).notifier).likeStore();
    }
    // 좋아요를 누르지 않은 상태면 좋아요
    else {
      await ref
          .read(storeProvider(widget.storeData.id).notifier)
          .dislikeStore();
    }
    setState(() {
      widget.storeData.like = !widget.storeData.like;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [shadow01]),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(children: [
              CircleAvatar(
                  backgroundImage: AssetImage(widget.storeData.thumbnail),
                  radius: 63 / 2),
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
                            onTap: onTapLikes,
                            child: SvgPicture.asset(
                                widget.storeData.like
                                    ? 'assets/icons/like=on_in.svg'
                                    : 'assets/icons/like=off_in.svg',
                                width: 24),
                          ),
                        ]),
                    const SizedBox(height: 1),
                    Text(
                        '${widget.storeData.distance}ㆍ${widget.storeData.address}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: gray05)),
                  ])),
            ]),
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 90 + 16,
              child: ListView.separated(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: widget.storeData.iamges.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 6),
                  itemBuilder: (context, index) => Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(widget.storeData.iamges[index],
                          fit: BoxFit.cover)))),
        ]));
  }
}
