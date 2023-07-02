import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/utils/colors.dart';

class StoreWidget extends StatelessWidget {
  final Function onTap;
  const StoreWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [shadow01],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      Text(
                        '블리스 케이크',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray08,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/like=on_in.svg',
                        width: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidStar,
                            size: 14,
                            color: orange01,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '4.5(100+)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: gray07,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  Text(
                    '0.3km · 20,000원~40,000원',
                    style: TextStyle(
                      fontSize: 12,
                      color: gray05,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '초코 제누와즈: 가나 슈필링',
                    style: TextStyle(
                      fontSize: 12,
                      color: gray06,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '바닐라 제누와즈: 버터크림 + 딸기잼필링',
                    style: TextStyle(
                      fontSize: 12,
                      color: gray06,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '당근케잌(건포도 + 크렌베리 + 호두):크림치즈 필링',
                    style: TextStyle(
                      fontSize: 12,
                      color: gray06,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
