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
  DateTime _selectedTime = DateTime.now();

  void _closed() {
    //pop되면서 선택된 시간을 전달
    Navigator.of(context).pop(_selectedTime);
  }

  void _onTimeChanged(DateTime newTime) {
    // print(newTime);
    setState(() {
      _selectedTime = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closed();
        return false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
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
          onDateTimeChanged: _onTimeChanged,
        ),
      ),
    );
  }
}
