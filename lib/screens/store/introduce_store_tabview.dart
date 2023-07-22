import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/my_divider_widget.dart';

class IntroduceStore extends StatefulWidget {
  const IntroduceStore({super.key});

  @override
  State<IntroduceStore> createState() => _IntroduceStoreState();
}

class _IntroduceStoreState extends State<IntroduceStore> {
  final scrollController = ScrollController();

  final double horizontalPadding = 18;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(height: 30),
      Scrollbar(
          controller: scrollController,
          child: SizedBox(
              height: 168,
              child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset('assets/heart_cake.png',
                          fit: BoxFit.fitHeight),
                    );
                  }))),
      const SizedBox(height: 16),
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
                  fontSize: 12, color: gray07, fontWeight: FontWeight.w400))),
      const MyDivider(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('영업 정보',
                style: TextStyle(
                    fontSize: 16, color: gray08, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: gray02),
                child: Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('사업자등록번호',
                        //     style: TextStyle(
                        //         fontSize: 12,
                        //         color: gray07,
                        //         fontWeight: FontWeight.w600)),
                        // const SizedBox(height: 6),
                        Text('픽업시간',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text('전화번호',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600))
                      ]),
                  const SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('123-45-67890',
                        //     style: TextStyle(
                        //         fontSize: 12,
                        //         color: gray05,
                        //         fontWeight: FontWeight.w600)),
                        // const SizedBox(height: 6),
                        Text('평일 12시~19시, 주말 12~18시',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray05,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text('010-1234-5678',
                            style: TextStyle(
                                fontSize: 12,
                                color: gray05,
                                fontWeight: FontWeight.w600)),
                      ]),
                ])),
          ])),
      // const MyDivider(),
      // Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20),
      //     child:
      //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //       Text('가계 통계',
      //           style: TextStyle(
      //               fontSize: 16, color: gray08, fontWeight: FontWeight.w600)),
      //       const SizedBox(height: 16),
      //       Container(
      //           padding: const EdgeInsets.all(16),
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(16), color: gray02),
      //           child: Row(children: [
      //             Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('최근 주문 수',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray07,
      //                           fontWeight: FontWeight.w600)),
      //                   const SizedBox(height: 6),
      //                   Text('전체 주문 수',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray07,
      //                           fontWeight: FontWeight.w600)),
      //                 ]),
      //             const SizedBox(width: 35),
      //             Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text('1,000',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray05,
      //                           fontWeight: FontWeight.w600)),
      //                   const SizedBox(height: 6),
      //                   Text('40,000',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           color: gray05,
      //                           fontWeight: FontWeight.w600)),
      //                 ]),
      //           ])),
      //     ])),
      const SizedBox(height: 50),
    ]);
  }
}
