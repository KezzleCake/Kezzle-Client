import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/my_divider_widget.dart';
import 'package:kezzle/widgets/review_widget.dart';

final tabs = ['가격', '가게 소개', '상세 위치', '리뷰'];

class DetailStoreScreen extends StatelessWidget {
  const DetailStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('스토어'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/share.svg'),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 63 / 2,
                    backgroundImage: AssetImage('assets/heart_cake.png'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '블리스 케이크',
                          style: TextStyle(
                            fontSize: 16,
                            color: gray08,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              size: 14,
                              color: orange01,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '4.5(100+)',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '블리스 케이크 만의 무드를 담은 케이크로 소중한 날을 더욱 특별하게 만들어드려요 :)',
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 12,
                            color: gray06,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Row(
                          children: [
                            FaIcon(FontAwesomeIcons.instagram),
                            SizedBox(
                              width: 13,
                            ),
                            FaIcon(FontAwesomeIcons.comment),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/like=on.svg'),
                        Text(
                          '55',
                          style: TextStyle(
                            fontSize: 12,
                            color: coral01,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            TabBar(
              splashFactory: NoSplash.splashFactory,
              labelColor: coral01,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: gray05,
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: coral01,
                    width: 2,
                  ),
                ),
              ),
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
            Flexible(
              // width: double.infinity,
              // height: 1,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StorePrice(),
                  const IntroStore(),
                  const StoreLocation(),
                  StoreReview(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//enum SingingCharacter { lafayette, jefferson }
class StorePrice extends StatefulWidget {
  const StorePrice({
    super.key,
  });

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
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: gray01,
            ),
          ),
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
                        CakeSizeWidget(
                          width: 42,
                          radius: 12,
                          sizeName: '미니',
                        ),
                        CakeSizeWidget(
                          width: 56,
                          radius: 15,
                          sizeName: '1호',
                        ),
                        CakeSizeWidget(
                          width: 60,
                          radius: 18,
                          sizeName: '2호',
                        ),
                        CakeSizeWidget(
                          width: 68,
                          radius: 21,
                          sizeName: '3호',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
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
            const MyDivider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '맛 선택',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: gray08,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
            const MyDivider(),
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
            const MyDivider(),
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

class CakeSizeWidget extends StatelessWidget {
  final double width;
  final int radius;
  final String sizeName;

  const CakeSizeWidget({
    super.key,
    required this.width,
    required this.radius,
    required this.sizeName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: gray01,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: width,
              height: 1,
              decoration: BoxDecoration(
                color: gray04,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: gray01,
              ),
              child: Text(
                '${radius}cm',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: gray05,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          sizeName,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: gray06,
          ),
        ),
      ],
    );
  }
}

class StoreLocation extends StatelessWidget {
  const StoreLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36 / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            '서울 서대문구 신촌로 1 쓰리알유씨티아파트상가건물 2층 204호',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gray06,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey,
            ),
            height: 300,
            width: double.infinity,
            child: const Center(
              child: Text('지도'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: gray04,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.locationDot,
                      size: 15,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  '장소 정보 자세히 보기',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: gray06,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoreReview extends StatelessWidget {
  final double horizontalPadding = 20.0;

  final List reviewUrlList = [
    'assets/heart_cake.png',
    'assets/heart_cake.png',
    'assets/heart_cake.png',
  ];

  StoreReview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '스토어 후기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: gray08,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '20명 참여',
                      style: TextStyle(
                        fontSize: 16,
                        color: gray05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: [
                    EvaluationScore(
                      evaluation: '맛있어요',
                      score: 90,
                    ),
                    EvaluationScore(
                      evaluation: '구현을 잘해줘요',
                      score: 78,
                    ),
                    EvaluationScore(
                      evaluation: '친절해요',
                      score: 70,
                    ),
                    EvaluationScore(
                      evaluation: '재료가 신선해요',
                      score: 90,
                    ),
                    EvaluationScore(
                      evaluation: '포장이 깔끔해요',
                      score: 90,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const MyDivider(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4.0',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: gray07),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        RatingBar.builder(
                          unratedColor: gray03,
                          ignoreGestures: true,
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => FaIcon(
                            FontAwesomeIcons.solidStar,
                            size: 14,
                            color: orange01,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '5점',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05,
                                ),
                              ),
                              Text(
                                '4점',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05,
                                ),
                              ),
                              Text(
                                '3점',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05,
                                ),
                              ),
                              Text(
                                '2점',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05,
                                ),
                              ),
                              Text(
                                '1점',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray05,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const SizedBox(
                            height: 85,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MyRatingBar(
                                  percent: 0.8,
                                ),
                                MyRatingBar(percent: 0.6),
                                MyRatingBar(percent: 0.3),
                                MyRatingBar(percent: 0.2),
                                MyRatingBar(percent: 0.1),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '17',
                                style: TextStyle(
                                  color: orange01,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '6',
                                style: TextStyle(
                                  color: orange01,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '5',
                                style: TextStyle(
                                  color: orange01,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '4',
                                style: TextStyle(
                                  color: orange01,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  color: orange01,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      '리뷰',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: gray08,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      '10건',
                      style: TextStyle(
                        fontSize: 16,
                        color: gray05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var reviewUrl in reviewUrlList)
                      Container(
                        // 6이 padding값(3개의 패딩)
                        width:
                            (MediaQuery.of(context).size.width - 40 - 3 * 6) /
                                4,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image(
                          image: AssetImage(reviewUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    GestureDetector(
                      onTap: () => {},
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              'assets/heart_cake.png',
                              width: (MediaQuery.of(context).size.width -
                                      horizontalPadding * 2 -
                                      3 * 6) /
                                  4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width -
                                    40 -
                                    3 * 6) /
                                4,
                            height: (MediaQuery.of(context).size.width -
                                    40 -
                                    3 * 6) /
                                4,
                            decoration: BoxDecoration(
                              color: dim01.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '+ 더보기',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: gray01,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        '최신순',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: coral01,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        '별점 높은 순',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gray05,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        '별점 낮은 순',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gray05,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const ReviewWidget(),
                //아래 잘 보이게 여백. 이것도 다 맞춰야 될 듯..
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyRatingBar extends StatelessWidget {
  final double percent;

  const MyRatingBar({
    super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 4,
          width: 6 * MediaQuery.of(context).size.width / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: gray03,
          ),
        ),
        Container(
          height: 4,
          width: 6 * MediaQuery.of(context).size.width / 13 * percent,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: orange01,
          ),
        ),
      ],
    );
  }
}

class EvaluationScore extends StatelessWidget {
  final String evaluation;
  final int score;

  const EvaluationScore({
    super.key,
    required this.evaluation,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: gray02,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$evaluation ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gray05,
            ),
          ),
          Text(
            '$score%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: coral01,
            ),
          ),
        ],
      ),
    );
  }
}

// class MyRatingBar extends StatelessWidget {
//   final int rating;
//   final int reviewCount;
//   final double percent;
//   final double width = 190;
//   const MyRatingBar({
//     super.key,
//     required this.rating,
//     required this.reviewCount,
//     required this.percent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text('$rating점'),
//         SizedBox(
//           width: 10,
//         ),
//         Stack(
//           children: [
//             Container(
//               height: 10,
//               width: width,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.grey[300],
//               ),
//             ),
//             Container(
//               height: 10,
//               width: width * percent,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.amber,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//     // return Row(
//     //   children: [
//     //     Text('$rating점'),
//     //     SizedBox(
//     //       width: width,
//     //       child: Stack(
//     //         children: [
//     //           Container(
//     //             height: 10,
//     //             decoration: BoxDecoration(
//     //               borderRadius: BorderRadius.circular(15),
//     //               color: Colors.grey[300],
//     //             ),
//     //           ),
//     //           Container(
//     //             height: 10,
//     //             width: width * percent,
//     //             decoration: BoxDecoration(
//     //               borderRadius: BorderRadius.circular(15),
//     //               color: Colors.amber,
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     Text('$reviewCount'),
//     //   ],
//     // );
//   }
// }

class IntroStore extends StatelessWidget {
  final double horizontalPadding = 18;
  const IntroStore({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 160,
            // scroll 바 위치 이상함.
            child: Scrollbar(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 12,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/heart_cake.png',
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              '안녕하세요~\n\n블리스 케이크 입니다. \n\n'
              '저희매장은 소중한날 행복할 수 있도록 정성스럽게\n제작해드리겠습니다. :)\n\n'
              '레터링 케이크의 제작은 '
              '픽업 당일 약속시간에 맞춰서 준비됩니다.\n'
              '너무 빨리 만들어놓는 경우 색번짐, 미세한 갈라짐,'
              '색변색등 있어 디자인은 미리해둘 수 없습니다!\n'
              '픽업시간보다 일찍 오시는 경우는 디자인이 되어있지'
              '않는 경우 또는 되어있더라도 냉각이 덜 되어 가져가시면'
              '케이크의 디자인이 변형 가능성이 높습니다!'
              '\n\n너무 늦게오시면 쇼케이스에 공간이 부족,'
              '다음 작업의 속도가 밀리게됩니다\n'
              '조금 늦으시는 경우는 꼭 카톡으로 남겨주세요!',
              style: TextStyle(
                fontSize: 12,
                color: gray07,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const MyDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '영업 정보',
                  style: TextStyle(
                    fontSize: 16,
                    color: gray08,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: gray02,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '사업자등록번호',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '픽업시간',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '전화번호',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '123-45-67890',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '평일 12시~19시, 주말 12~18시',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '010-1234-5678',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MyDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '가계 통계',
                  style: TextStyle(
                    fontSize: 16,
                    color: gray08,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: gray02,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '최근 주문 수',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '전체 주문 수',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray07,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1,000',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '40,000',
                            style: TextStyle(
                              fontSize: 12,
                              color: gray05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
