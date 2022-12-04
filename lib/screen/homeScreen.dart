import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/todayBanner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
      DateTime
          .now()
          .year,
      DateTime
          .now()
          .month,
      DateTime
          .now()
          .day
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Calendar(
                selectedDay: selectedDay,
                focusedDay: focusedDay,
                onDaySelected: onDaySelcted,
              ),
              SizedBox(height: 8,),
              TodayBanner(
                  selectedDay: selectedDay,
                  scheduleCount: 3
              )
            ],
          ),
        )
    );
  }

  onDaySelcted(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
