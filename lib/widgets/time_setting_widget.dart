import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSettingWidget extends StatefulWidget {
  const TimeSettingWidget({
    super.key,
  });

  @override
  State<TimeSettingWidget> createState() => _TimeSettingWidgetState();
}

class _TimeSettingWidgetState extends State<TimeSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 237,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (DateTime newDateTime) {
          print(newDateTime);
        },
      ),
    );
  }
}
