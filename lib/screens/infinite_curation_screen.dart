import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/curation_repo.dart';
import 'package:kezzle/screens/more_curation_screen.dart';
import 'package:kezzle/widgets/cake_with_keyword_widget.dart';

class InfiniteCurationScreen extends ConsumerStatefulWidget {
  static const routeName = '/infinite_curation_screen';
  static const routeUrl = '/infinite_curation_screen';
  final String curationId;
  final String curationDescription;

  const InfiniteCurationScreen(
      {super.key, required this.curationId, required this.curationDescription});

  @override
  ConsumerState<InfiniteCurationScreen> createState() =>
      _InfiniteCurationScreenState();
}

class _InfiniteCurationScreenState
    extends ConsumerState<InfiniteCurationScreen> {
  // List<String> items = List.generate(15, (index) => 'Item ${index + 1}');
  // List<String> items = [];
  List<Cake> items = [];
  final controller = ScrollController();
  int page = 0;
  bool hasMore = true;
  bool isLoading = false;
  final List<double> widthList = [240, 174, 200, 174];

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      items.clear();
    });

    fetch();

    // api 요청
    // await Future.delayed(const Duration(seconds: 1));
    // //api 요청 결과로 리스트 업데이트
    // setState(() {
    //   List<String> items = List.generate(15, (index) => 'Item ${index + 1}');
    //   this.items.addAll(items);
    // });
  }

  @override
  void initState() {
    super.initState();

    fetch();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset
          // controller.offset > controller.position.maxScrollExtent - 300
          ) {
        print('????');
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetch() async {
    if (isLoading) return;

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    // limit 잘 제한하기
    const limit = 20;
    // limit, page로 api 요청
    // api 요청해서 받아오기
    // await Future.delayed(const Duration(seconds: 2));

    List<Cake> newItems = [];
    final response = await ref
        .read(curationRepo)
        .fetchCurationCakesById(curationId: widget.curationId, page: page);
    response['cakes'].forEach((cake) {
      newItems.add(Cake.fromJson(cake));
    });

    if (mounted) {
      setState(() {
        page++;
        isLoading = false;
        if (newItems.length < limit) {
          hasMore = false;
        }
        items.addAll(newItems);
      });
    }

    // final List<String> newItems =
    //     List.generate(15, (index) => 'Item ${index + 1}');

    // setState(() {
    //   page++;
    //   // isLoading = false;

    //   if (newItems.length < limit) {
    //     hasMore = false;
    //   }
    //   items.addAll(newItems);
    // });
  }

  //TODO: circular progress indicator 위치 변경하기.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.curationDescription
              .replaceAll(RegExp('\n'), ' ')
              .replaceAll(RegExp('  '), ' '))),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                MasonryGridView.builder(
                    // shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    mainAxisSpacing: 23,
                    crossAxisSpacing: 5,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 80, top: 20),
                    // itemCount: cakeLength,
                    itemCount: items.length + 2,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      // List<String> keywords = ['생일', '파스텔', '초코'];

                      if (index < items.length) {
                        return CakeKeywordWidget(
                            width: widthList[index % 4], cake: items[index]);
                      } else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: hasMore
                                  ?
                                  // 중앙에 하나만 두려면?
                                  // const CircularProgressIndicator()
                                  Container()
                                  : const Text('마지막입니다.'),
                            ));
                      }
                    }),
                if (isLoading) // isLoading 값에 따라 CircularProgressIndicator 표시 결정
                  const Positioned(
                      bottom: 65,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
              ],
            ),
    );
  }
}
