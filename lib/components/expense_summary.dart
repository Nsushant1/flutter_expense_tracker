import 'package:expense_tracker/bar_graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {

    //get yyyymmdd for startOfWeek
    String sunday=convertDateTimeToString(startOfWeek.add(Duration(days:0)));
    String monday=convertDateTimeToString(startOfWeek.add(Duration(days:1)));
    String tuesday=convertDateTimeToString(startOfWeek.add(Duration(days:2)));
    String wednesday=convertDateTimeToString(startOfWeek.add(Duration(days:3)));
    String thursday=convertDateTimeToString(startOfWeek.add(Duration(days:4)));
    String friday=convertDateTimeToString(startOfWeek.add(Duration(days:5)));
    String saturday=convertDateTimeToString(startOfWeek.add(Duration(days:6)));


    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY:100,
          sunAmount: value.calcuateDailyExpenseSummary()[sunday] ?? 0,
          monAmount: value.calcuateDailyExpenseSummary()[monday] ?? 0,
          tueAmount: value.calcuateDailyExpenseSummary()[tuesday] ?? 0,
          wedAmount: value.calcuateDailyExpenseSummary()[wednesday] ?? 0, 
          thursAmount: value.calcuateDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.calcuateDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.calcuateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
