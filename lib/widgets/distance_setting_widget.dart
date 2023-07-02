import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class DistanceSettingWidget extends StatefulWidget {
  const DistanceSettingWidget({super.key});

  @override
  State<DistanceSettingWidget> createState() => _DistanceSettingWidgetState();
}

class _DistanceSettingWidgetState extends State<DistanceSettingWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 160,
            child: ListView(
              children: [
                for (int i = 0; i < 10; i++)
                  GestureDetector(
                    onTap: () {}, // 이거 선택하면 바로 그냥.. 할까..? 아니면 고르고, 창을 닫아줘야하나??
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Text(
                        '${i + 1}km',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: i == selectedIndex ? coral01 : gray05,
                        ),
                      ),
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
