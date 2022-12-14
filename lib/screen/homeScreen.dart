import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/todayBanner.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:calendar_scheduler/database/driftDatabase.dart';
import 'package:calendar_scheduler/model/scheduleWithColor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../component/newScheduleBottomSheet.dart';
import '../component/scheduleCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

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
                onDaySelected: onDaySelected,
              ),
              SizedBox(
                height: 8,
              ),
              TodayBanner(selectedDay: selectedDay),
              SizedBox(
                height: 8,
              ),
              _ScheduleList(
                selectedDate: selectedDay,
              )
            ],
          ),
        ));
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDate: selectedDay,
              );
            });
      },
      child: Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(
              selectedDate
            ),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && snapshot.data!.isEmpty){
                return Center(
                  child: Text('No Data'),
                );
              }


              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemBuilder: (context, index) {
                  final scheduleWithColor = snapshot.data![index];

                  return ScheduleCard(
                    startTime: scheduleWithColor.schedule.startTime,
                    endTime: scheduleWithColor.schedule.endTime,
                    content: scheduleWithColor.schedule.content,
                    color: Color(
                      int.parse('FF${scheduleWithColor.categoryColor.hexCode}', radix: 16)
                    )
                  );
                },
              );
            }),
      ),
    );
  }
}
