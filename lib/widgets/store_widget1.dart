import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';

class StoreWidget1 extends StatefulWidget {
  // bool liked = false;
  final HomeStoreModel storeData;

  const StoreWidget1({
    super.key,
    required this.storeData,
  });

  @override
  State<StoreWidget1> createState() => _StoreWidget1State();
}

class _StoreWidget1State extends State<StoreWidget1> {
  void onTapLikes() {
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
