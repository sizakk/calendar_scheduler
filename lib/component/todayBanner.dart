import 'package:calendar_scheduler/constant/colors.dart';
import 'package:calendar_scheduler/model/scheduleWithColor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../database/driftDatabase.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;


  const TodayBanner(
      {required this.selectedDay, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        TextStyle(fontWeight: FontWeight.w600, color: Colors.white);

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
                style: textStyle),
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                int count = 0;

                if(snapshot.hasData){
                  count = snapshot.data!.length;
                }

                return Text(
                  '$count개',
                  style: textStyle,
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
