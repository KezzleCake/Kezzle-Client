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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: applied! ? orange01 : gray04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            keyword,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: applied! ? orange01 : gray06,
            ),
          ),
          applied! ? const SizedBox(width: 5) : Container(),
          applied!
              ? GestureDetector(
                  // onTap: () => print('delete'),
                  onTap: () => deleteFunction(),
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    size: 12,
                    color: gray04,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
