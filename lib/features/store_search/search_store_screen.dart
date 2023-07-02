import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/utils/colors.dart';

class SearchStore extends StatelessWidget {
  const SearchStore({super.key});

  final int storeCount = 6;

  void onTapSearchBar(BuildContext context) {
    print('search bar tapped');
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: Colors.amber,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => onTapSearchBar(context),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                '서울 강남구 테헤란로',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: gray08,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/arrow-down.svg',
                colorFilter: ColorFilter.mode(
                  gray07,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                '2km',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: gray08,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/arrow-down.svg',
                colorFilter: ColorFilter.mode(
                  gray07,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green,
          ),
          DraggableScrollableSheet(
            // 2는 store widget의 개수(가변적일 것)
            // 0개면 뭐보여주지... 뭐 없다고 띄워줘야겠다.
            maxChildSize: 0.4 * (storeCount == 0 ? 1 : storeCount) > 1
                ? 1
                : 0.4 * (storeCount == 0 ? 1 : storeCount), //max 1 로 주기
            initialChildSize: 0.3,
            minChildSize: 0.23,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      // height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    '거리순',
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
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    '낮은 가격순',
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
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    '별점순',
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
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    '후기순',
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
                              height: 8,
                            ),
                            storeCount != 0
                                ? ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: storeCount,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const StoreWidget();
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Divider(
                                            color: gray03,
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(
                                      top: 50,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text('검색된 스토어가 없습니다.'),
                                  ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StoreWidget extends StatelessWidget {
  const StoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '21케이크',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: gray08,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.solidStar,
              size: 14,
              color: orange01,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '4.5 (100+)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: gray07,
              ),
            ),
            Expanded(
              child: Text(
                '200m · 서울 강남구 역삼동',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: gray05,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width - 40 - 6 * 3) / 4,
              height: (MediaQuery.of(context).size.width - 40 - 6 * 3) / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/heart_cake.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: SizedBox(
                height: (MediaQuery.of(context).size.width - 40 - 6 * 3) / 4,
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 6,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/heart_cake.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
