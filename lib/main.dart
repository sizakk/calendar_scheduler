import 'package:calendar_scheduler/screen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NotoSans'),
    home: HomeScreen(),
  ));
}
