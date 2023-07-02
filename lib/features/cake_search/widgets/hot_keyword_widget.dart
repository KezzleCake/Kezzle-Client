import 'package:flutter/material.dart';

class HotKeyWordWidget extends StatefulWidget {
  const HotKeyWordWidget({super.key});

  @override
  State<HotKeyWordWidget> createState() => _HotKeyWordWidgetState();
}

class _HotKeyWordWidgetState extends State<HotKeyWordWidget> {
  final int itemsPerPage = 6; // 한 페이지에 표시할 항목 개수
  int currentPage = 0; // 현재 페이지 인덱스

  List<String> hotRankingData = [
    'Keyword 1',
    'Keyword 2',
    'Keyword 3',
    'Keyword 4',
    'Keyword 5',
    'Keyword 6',
    'Keyword 7',
    'Keyword 8',
    'Keyword 9',
    'Keyword 10',
    'Keyword 11',
    'Keyword 12',
    'Keyword 13',
    'Keyword 14',
    'Keyword 15',
    'Keyword 16',
    'Keyword 17',
    'Keyword 18',
  ];

  @override
  Widget build(BuildContext context) {
    // final int pageCount =
    //     (hotRankingData.length / itemsPerPage).ceil(); // 전체 페이지 개수

    return const DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '인기 검색 키워드',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF979797),
                ),
              ),
              Text(
                '업데이트 07:00',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF979797),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: TabBarView(
              children: [
                HotPage(),
                HotPage(),
                HotPage(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabPageSelector(
                borderStyle: BorderStyle.none,
                indicatorSize: 8,
                color: Color(0xFFD9D9D9),
                selectedColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HotPage extends StatelessWidget {
  const HotPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '1    친구',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '2    생일',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '3    여자친구',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              )
            ],
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '4    부모님',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '5    축하',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '6    취업',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(Icons.horizontal_rule, size: 15),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
