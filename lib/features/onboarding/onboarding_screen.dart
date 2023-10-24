import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/shared_preference_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  static const routeURL = '/onboarding';
  static const routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  //페이지뷰 컨트롤러
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPage = _pageController.page!;
      setState(() {});
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void onTapStart() {
    // print('허이');
    // 온보딩 완료
    ref.read(sharedPreferenceRepo).setBool('onboarding', false);
    context.go(LoginScreen.routeURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Stack(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(controller: _pageController, children: const [
                OnboardingWidget(
                    title: '기념일을 위한\n케이크 쉽게 찾기',
                    description: '소중한 사람과의 기념일을 위한\n멋진 케이크 디자인을 찾아보세요.',
                    image: 'assets/onboarding/onboarding1.png'),
                OnboardingWidget(
                    title: '주변에서\n비슷한 케이크 찾기',
                    description:
                        '선택한 케이크가 먼 곳에 위치해 있나요?\n내 주변에서 비슷한 디자인을 찾아볼 수 있습니다.',
                    image: 'assets/onboarding/onboarding2.png'),
                OnboardingWidget(
                    title: '간편하게\n주문완료 하기',
                    description:
                        '선택한 케이크 디자인을 복사/저장 후,\n스토어의 카카오톡에 전달하고 주문을 완료해보세요.',
                    image: 'assets/onboarding/onboarding3.png'),
                OnboardingWidget(
                    title: '가까운 스토어/케이크\n모아보기',
                    description: '위치와 반경을 설정하여 내 주변에 있는\n스토어/케이크만 모아볼 수 있습니다.',
                    image: 'assets/onboarding/onboarding4.png'),
              ])),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // 4개 반복
                for (int i = 0; i < 4; i++) ...[
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: coral01,
                        border: Border.all(
                            color:
                                _currentPage.round() == i ? coral01 : coral04,
                            width: 4.5),
                      )),
                  const SizedBox(width: 7),
                ],
              ])),
        ]))),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: IgnorePointer(
                ignoring: _currentPage.round() != 3,
                child: GestureDetector(
                  onTap: onTapStart,
                  child: AnimatedContainer(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _currentPage.round() == 3 ? coral01 : gray01,
                          borderRadius: BorderRadius.circular(30)),
                      clipBehavior: Clip.hardEdge,
                      duration: const Duration(milliseconds: 100),
                      child: Text('시작하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: gray01,
                          ))),
                ))));
  }
}

class OnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        // '기념일을 위한\n손쉬운 케이크 탐색',
                        style: TextStyle(
                          height: 1.1,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: gray08,
                        )),
                    const SizedBox(height: 10),
                    Text(description,
                        // '소중한 사람과의 기념일을 위한\n멋진 케이크 디자인을 찾아보세요.',
                        style: TextStyle(
                            height: 1.1,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: gray08)),
                    const SizedBox(height: 15),
                  ]),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 510 / 844,
            // width: MediaQuery.of(context).size.width - 40,
            child: Image.asset(
              image,
              fit: BoxFit.fitHeight,
              // fit: BoxFit.fitWidth,
              // fit: BoxFit.cover,
              // 'assets/onboarding/onboarding1.png',
              // height: MediaQuery.of(context).size.height * 415 / 844,
            ),
          ),
        ]);
  }
}
