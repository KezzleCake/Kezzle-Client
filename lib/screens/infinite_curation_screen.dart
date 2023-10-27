import 'package:flutter/material.dart';

class InfiniteCurationScreen extends StatefulWidget {
  static const routeName = '/infinite_curation_screen';
  static const routeUrl = '/infinite_curation_screen';

  const InfiniteCurationScreen({super.key});

  @override
  State<InfiniteCurationScreen> createState() => _InfiniteCurationScreenState();
}

class _InfiniteCurationScreenState extends State<InfiniteCurationScreen> {
  // List<String> items = List.generate(15, (index) => 'Item ${index + 1}');
  List<String> items = [];
  final controller = ScrollController();
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;

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
      if (controller.position.maxScrollExtent == controller.offset) {
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
    // if (isLoading) return;

    // isLoading = true;

    const limit = 25;
    // limit, page로 api 요청
    // api 요청해서 받아오기
    await Future.delayed(const Duration(seconds: 1));
    final List<String> newItems = List.generate(15, (index) => 'Item ${index + 1}');

    setState(() {
      page++;
      // isLoading = false;

      // if (newItems.length < limit) {
      //   hasMore = false;
      // }
      // items = [...items, ...newItems];
      // items.addAll(['Item A', 'Item B', 'Item C', 'Item D', 'Item E']);
      items.addAll(newItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('무한큐레이션'),
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item),
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                              child:
                                  // hasMore    ?
                                  const CircularProgressIndicator()
                              // : const Text('마지막입니다.'),
                              ));
                    }
                  }),
            ),
    );
  }
}
