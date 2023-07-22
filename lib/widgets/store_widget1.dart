import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kezzle/utils/colors.dart';

class StoreWidget1 extends StatelessWidget {
  bool liked = false;

  StoreWidget1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow01],
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Row(children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/heart_cake.png'),
              radius: 63 / 2,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('본비케이크',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: gray08)),
                        liked
                            ? SvgPicture.asset(
                                'assets/icons/like=on_in.svg',
                                width: 24,
                              )
                            : SvgPicture.asset(
                                'assets/icons/like=off_in.svg',
                                width: 24,
                              ),
                      ]),
                  const SizedBox(height: 1),
                  Text('0.3kmㆍ서울 강남구 역삼동',
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
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 6),
            itemBuilder: (context, index) => Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset('assets/heart_cake.png', fit: BoxFit.cover)),
          ),
        ),
      ]),
    );
  }
}
