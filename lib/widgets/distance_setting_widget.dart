import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class DistanceSettingWidget extends ConsumerStatefulWidget {
  final int initialValue;
  const DistanceSettingWidget({super.key, required this.initialValue});

  @override
  DistanceSettingWidgetState createState() => DistanceSettingWidgetState();
}

class DistanceSettingWidgetState extends ConsumerState<DistanceSettingWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialValue - 1;
  }

  void _closed() {
    //pop되면서 선택된 거리를 전달
    // Navigator.of(context).pop(selectedIndex + 1);
    //print(selectedIndex + 1);

    // pop 되면서 선택된 거리로 데이터 변경
    // selectedIndex + 1과 값이 다르면 변경
    if (ref.read(searchSettingViewModelProvider).radius != selectedIndex + 1) {
      ref
          .read(searchSettingViewModelProvider.notifier)
          .setRadius(selectedIndex + 1);
    }
    // Navigator.of(context).pop();

    // 반경 뭘로 변경하는지 체크
    ref
        .read(analyticsProvider)
        .gaEvent('btn_radius_setting', {'radius': selectedIndex + 1});

    context.pop();
  }

  void onSelectedItemChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    // print(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closed();
        return false;
      },
      child: Container(
        height: 215,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40,
            onSelectedItemChanged: onSelectedItemChanged,
            children: [
              for (int i = 0; i < 10; i++)
                Padding(
                    padding: const EdgeInsets.only(
                      top: 11,
                    ),
                    child: Text(
                      '${i + 1}km',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: i == selectedIndex ? coral01 : gray05),
                    ))
            ]),
        // child: Column(
        //   children: [
        //     const SizedBox(
        //       height: 24,
        //     ),
        //     SizedBox(
        //       height: 160,
        //       child: ListView(
        //         children: [
        //           for (int i = 0; i < 10; i++)
        //             GestureDetector(
        //               onTap: () {}, // 이거 선택하면 바로 그냥.. 할까..? 아니면 고르고, 창을 닫아줘야하나??
        //               child: Container(
        //                 padding: const EdgeInsets.symmetric(
        //                   horizontal: 16,
        //                   vertical: 20,
        //                 ),
        //                 child: Text(
        //                   '${i + 1}km',
        //                   style: TextStyle(
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.w700,
        //                     color: i == selectedIndex ? coral01 : gray05,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
