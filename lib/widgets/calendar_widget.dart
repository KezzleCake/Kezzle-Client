import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  // void Function
  const CalendarWidget({
    super.key,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
    print(_selectedDay);
  }

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
      height: 450,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        child: TableCalendar(
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          focusedDay: _focusedDay,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          locale: 'ko-KR',
          daysOfWeekHeight: 30,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: gray06,
            ),
            // 화살표 간격 줄이려면 .. 어케해야됨...?
            // leftChevronPadding: EdgeInsets.zero,
            // rightChevronMargin: EdgeInsets.zero,
            headerPadding: const EdgeInsets.symmetric(
              horizontal: 69,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: gray05,
            ),
            weekendStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: gray05,
            ),
          ),
          rowHeight: 44,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            defaultTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: gray08,
            ),
            weekendTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: gray08,
            ),
            selectedTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: gray01,
            ),
            todayTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: orange01,
            ),
            todayDecoration: const BoxDecoration(),
            selectedDecoration: BoxDecoration(
              color: orange01,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
