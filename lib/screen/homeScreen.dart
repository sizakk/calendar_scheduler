import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/todayBanner.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

import '../component/newScheduleBottomSheet.dart';
import '../component/scheduleCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: renderFloatingActionButton(),
        body: SafeArea(
          child: Column(
            children: [
              Calendar(
                selectedDay: selectedDay,
                focusedDay: focusedDay,
                onDaySelected: onDaySelcted,
              ),
              SizedBox(
                height: 8,
              ),
              TodayBanner(selectedDay: selectedDay, scheduleCount: 3),
              SizedBox(
                height: 8,
              ),
              _ScheduleList()
            ],
          ),
        ));
  }

  FloatingActionButton renderFloatingActionButton(){
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: (){
        showModalBottomSheet(
          isScrollControlled: true,
            context: context,
            builder: (_){
              return ScheduleBottomSheet();
            }
        );
      },
        child: Icon(Icons.add),
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

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8,
            );
          },
          itemBuilder: (context, index) {
            return ScheduleCard(
                startTime: 8,
                endTime: 13,
                content: '프로그래밍. $index',
                color: Colors.red);
          },
        ),
      ),
    );
  }
}

