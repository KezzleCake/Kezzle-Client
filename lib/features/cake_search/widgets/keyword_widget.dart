import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/utils/colors.dart';

// class KeywordWidget extends StatelessWidget {
//   const KeywordWidget({
//     super.key,
//     required this.keyword,
//     required this.color,
//   });

//   final String keyword;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color,
//         // border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             keyword,
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(width: 5),
//           GestureDetector(
//               onTap: () => print('delete'),
//               child: const FaIcon(FontAwesomeIcons.squareXmark, size: 14)),
//         ],
//       ),
//     );
//   }
// }
class KeywordWidget extends StatelessWidget {
  final String keyword;
  final bool? applied;
  final Function deleteFunction;

  const KeywordWidget({
    super.key,
    required this.keyword,
    this.applied = false,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          left: 10,
          right: applied ?? false ? 0 : 10,
          top: applied ?? false ? 0 : 6,
          bottom: applied ?? false ? 0 : 6,
          // horizontal: 10, vertical: 6
        ),
        decoration: BoxDecoration(
          border: Border.all(color: coral01),
          // color: applied! ? gray01 : coral02,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          Text(keyword,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: applied! ? coral01 : gray05,
              )),
          // applied! ? const SizedBox(width: 5) : Container(),
          applied!
              ? InkWell(
                  highlightColor: Colors.transparent, // 눌린 상태에서 물결 효과 비활성화
                  splashColor: Colors.transparent,
                  // onTap: () => print('delete'),
                  onTap: () => deleteFunction(),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 10.0, top: 6.0, bottom: 6),
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        size: 12,
                        color: gray04,
                      )))
              : Container(),
        ]));
  }
}
