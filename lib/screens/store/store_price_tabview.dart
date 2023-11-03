import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kezzle/screens/store/widgets/cake_size_widget.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/my_divider_widget.dart';

class StorePrice extends StatefulWidget {
  const StorePrice({super.key});

  @override
  State<StorePrice> createState() => _StorePriceState();
}

class _StorePriceState extends State<StorePrice> {
  final double horizontalPadding = 18;
  int _sizeCharacter = 0;
  int _tasteCharacter = 0;
  int totalPrice = 0;
  String _letter = '';
  final TextEditingController _textEditingController = TextEditingController();

  final List<Map<String, dynamic>> sizeOption = [
    {'index': 0, 'size': '미니', 'price': 20000},
    {'index': 1, 'size': '1호', 'price': 30000},
    {'index': 2, 'size': '2호', 'price': 40000},
    {'index': 3, 'size': '3호', 'price': 50000},
  ];

  final List<Map<String, dynamic>> tasteOption = [
    {
      'index': 0,
      'taste': '바닐라 제누와즈 & 버터크림 & 딸기잼',
      'tasteDescription': '카스테라빵에 딸기잼과 우유버터크림을 함께먹는 맛! \n가장기본적인 케이크 맛입니다!',
      'additionalPrice': 3000,
    },
    {
      'index': 1,
      'taste': '초코 제누와즈 & 가나슈필링',
      'tasteDescription': '초코빵에 초코크림을 함께먹는 맛! \n음! 초코네 하는 맛이에요!',
      'additionalPrice': 1000,
    },
    {
      'index': 2,
      'taste': '당근케이크 & 크림치즈 필링',
      'tasteDescription': '시나몬향을 느낄 수 있는 당근케이크 맛! \n견과류와 크림치즈가 잘 어울려요',
      'additionalPrice': 0,
    },
  ];

  final List<Map<String, dynamic>> designOption = [
    {'designOp': '포토', 'additionalPrice': 3000, 'selected': false},
    {'designOp': '진한 바탕색', 'additionalPrice': 2000, 'selected': false},
    {'designOp': '큰모양 테두리 데코', 'additionalPrice': 1000, 'selected': false},
    {'designOp': '작은모양 테두리 데코', 'additionalPrice': 500, 'selected': false},
    {'designOp': '캐릭터', 'additionalPrice': 1000, 'selected': false},
  ];

  @override
  void initState() {
    super.initState();
    _sizeCharacter = sizeOption[0]['index'];
    _tasteCharacter = tasteOption[0]['index'];
    totalPrice = sizeOption[0]['price'] + tasteOption[0]['additionalPrice'];
    _textEditingController.addListener(() {
      setState(() {
        _letter = _textEditingController.text;
      });
    });
    // setState(() {});
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // surfaceTintColor: Colors.black,
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: coral01,
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.hardEdge,
          child: Text(
              '${NumberFormat.decimalPattern().format(totalPrice)}원 주문하기',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: gray01)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '사이즈 선택',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: gray08,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: gray03,
                      ),
                      color: gray02,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CakeSizeWidget(width: 42, radius: 12, sizeName: '미니'),
                        CakeSizeWidget(width: 56, radius: 15, sizeName: '1호'),
                        CakeSizeWidget(width: 60, radius: 18, sizeName: '2호'),
                        CakeSizeWidget(width: 68, radius: 21, sizeName: '3호'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (Map<String, dynamic> option in sizeOption)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      horizontalTitleGap: 8,
                      leading: Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        fillColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return coral01;
                            }
                            return gray03;
                          },
                        ),
                        value: option['index'], // 이 라디오 버튼이 갖는 값
                        groupValue: _sizeCharacter, // 현재 선택된 값
                        onChanged: (dynamic value) {
                          //기존 선택된 가격 없애고, 새로 선택된 가격 더하기
                          totalPrice -=
                              sizeOption[_sizeCharacter]['price'] as int;
                          totalPrice += option['price'] as int;
                          _sizeCharacter = value as int;
                          setState(() {});
                        },
                      ),
                      title: Text(
                        option['size'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray07,
                        ),
                      ),
                      trailing: Text(
                        '${NumberFormat.decimalPattern().format(option['price'])}원',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: orange01,
                        ),
                      ),
                    ),
                ],
              ),
            ),
             MyDivider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('맛 선택',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray08)),
                  const SizedBox(height: 5),
                  for (Map<String, dynamic> option in tasteOption)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      horizontalTitleGap: 8,
                      leading: Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        fillColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return coral01;
                            }
                            return gray03;
                          },
                        ),
                        value: option['index'],
                        groupValue: _tasteCharacter,
                        onChanged: (dynamic value) {
                          //기존 선택된 가격 없애고, 새로 선택된 가격 더하기
                          totalPrice -= tasteOption[_tasteCharacter]
                              ['additionalPrice'] as int;
                          totalPrice += option['additionalPrice'] as int;
                          _tasteCharacter = value as int;
                          setState(() {});
                        },
                      ),
                      title: Text(
                        option['taste'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray07,
                        ),
                      ),
                      subtitle: Text(
                        option['tasteDescription'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: gray05,
                        ),
                      ),
                      isThreeLine: true,
                      trailing: Text(
                        '+${NumberFormat.decimalPattern().format(option['additionalPrice'])}원',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: orange01,
                        ),
                      ),
                    ),
                ],
              ),
            ),
             MyDivider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '디자인 선택',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: gray08,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.hardEdge,
                        width: 83,
                        height: 83,
                        child: Image.asset(
                          'assets/heart_cake.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // FaIcon(
                      //   FontAwesomeIcons.circleXmark,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset('assets/icons/x-circle.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (Map<String, dynamic> option in designOption)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      horizontalTitleGap: 8,
                      leading: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return coral01;
                              }
                              return gray03;
                            },
                          ),
                          value: option['selected'],
                          onChanged: (value) {
                            // 선택됐으면 가격 더하고, 선택 안됐으면 가격 빼기
                            if (value!) {
                              totalPrice += option['additionalPrice'] as int;
                            } else {
                              totalPrice -= option['additionalPrice'] as int;
                            }
                            option['selected'] = value;
                            setState(() {});
                          }),
                      title: Text(
                        option['designOp'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray07,
                        ),
                      ),
                      trailing: Text(
                        '+${NumberFormat.decimalPattern().format(option['additionalPrice'])}원',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: orange01,
                        ),
                      ),
                    ),
                ],
              ),
            ),
             MyDivider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '문구 추가',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: gray08,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 8,
                    leading: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        fillColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return coral01;
                            }
                            return gray03;
                          },
                        ),
                        value: false,
                        onChanged: (value) {}),
                    title: TextField(
                      controller: _textEditingController,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray06,
                      ),
                      decoration: InputDecoration(
                        suffix: Text(
                          '0/10',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: gray05,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        hintText: '레터링 문구를 요청할 수 있어요.',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray04,
                        ),
                        fillColor: gray02,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: gray03,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: gray03,
                          ),
                        ),
                      ),
                    ),
                    trailing: Text(
                      '+3,000원',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: orange01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
