import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/store_widget.dart';
// import 'package:kezzle/features/store_search/search_store_screen.dart';

class BookmarkScreen extends StatelessWidget {
  final List<String> tabList = ['스토어', '디자인'];

  BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '찜',
          style: TextStyle(
            color: gray08,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                splashFactory: NoSplash.splashFactory,
                labelColor: coral01,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: gray05,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: coral01,
                      width: 2,
                    ),
                  ),
                ),
                tabs: [
                  Tab(
                    text: tabList[0],
                  ),
                  Tab(
                    text: tabList[1],
                  ),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    // 첫번째 항목이 그림자 너무 안보이긴 한다
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 30,
                      ),
                      child: ListView.separated(
                        itemCount: 4,
                        itemBuilder: (context, index) => StoreWidget(
                          onTap: (context) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SearchStoreScreen(),
                            //   ),
                            // );
                          },
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                      ),
                    ),
                    //디자인 탭 화면
                    GridView.builder(
                      itemCount: 20,
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 20,
                        right: 20,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [shadow01],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.asset(
                              'assets/heart_cake.png',
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/like=on_in.svg',
                                    colorFilter: ColorFilter.mode(
                                      coral01,
                                      BlendMode.srcATop,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'assets/icons/like=off.svg',
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcATop,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
