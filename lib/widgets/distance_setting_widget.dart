import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class DistanceSettingWidget extends StatefulWidget {
  const DistanceSettingWidget({super.key});

  @override
  State<DistanceSettingWidget> createState() => _DistanceSettingWidgetState();
}

class _DistanceSettingWidgetState extends State<DistanceSettingWidget> {
  int selectedIndex = 0;

  void _closed() {
    //pop되면서 선택된 시간을 전달
    Navigator.of(context).pop(selectedIndex + 1);
  }

  void onSelectedItemChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
    print(selectedIndex);
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
          ),
        ),
        child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40,
            onSelectedItemChanged: onSelectedItemChanged,
            children: [
              for (int i = 0; i < 10; i++)
                Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
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
