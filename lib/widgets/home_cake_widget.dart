import 'package:flutter/material.dart';
import 'package:kezzle/models/cake_model.dart';
import 'package:kezzle/utils/colors.dart';

class HomeCakeWidget extends StatelessWidget {
  final CakeModel cakeData;

  const HomeCakeWidget({
    super.key,
    required this.cakeData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => onTapCake(context, 'assets/heart_cake.png'),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), boxShadow: [shadow01]),
          clipBehavior: Clip.hardEdge,
          child: Stack(alignment: Alignment.bottomRight, children: [
            Image.asset(cakeData.url, fit: BoxFit.cover),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Stack(children: [
            //       SvgPicture.asset(
            //         'assets/icons/like=on_in.svg',
            //         colorFilter: ColorFilter.mode(
            //           coral01,
            //           BlendMode.srcATop,
            //         ),
            //       ),
            //       SvgPicture.asset('assets/icons/like=off.svg',
            //           colorFilter: const ColorFilter.mode(
            //               Colors.white, BlendMode.srcATop)),
            //     ])),
          ])),
    );
  }
}
