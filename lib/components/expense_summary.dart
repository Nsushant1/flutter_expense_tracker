import 'package:expense_tracker/bar_graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  //calculate the max amount
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;
    List<double> values = [
      value.calcuateDailyExpenseSummary()[sunday] ?? 0,
      value.calcuateDailyExpenseSummary()[monday] ?? 0,
      value.calcuateDailyExpenseSummary()[tuesday] ?? 0,
      value.calcuateDailyExpenseSummary()[wednesday] ?? 0,
      value.calcuateDailyExpenseSummary()[thursday] ?? 0,
      value.calcuateDailyExpenseSummary()[friday] ?? 0,
      value.calcuateDailyExpenseSummary()[saturday] ?? 0,
    ];
    //sort
    values.sort();

    //get largest amount
    max = values.last * 1.5;
    return max == 0 ? 100 : max;
  }

  //calculate week total
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calcuateDailyExpenseSummary()[sunday] ?? 0,
      value.calcuateDailyExpenseSummary()[monday] ?? 0,
      value.calcuateDailyExpenseSummary()[tuesday] ?? 0,
      value.calcuateDailyExpenseSummary()[wednesday] ?? 0,
      value.calcuateDailyExpenseSummary()[thursday] ?? 0,
      value.calcuateDailyExpenseSummary()[friday] ?? 0,
      value.calcuateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total =0;
    for(int i=0;i<values.length;i++){
      total=total+values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    //get yyyymmdd for startOfWeek
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tuesday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 2)),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 3)),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 4)),
    );
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday = convertDateTimeToString(
      startOfWeek.add(Duration(days: 6)),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //week summary
          Row(
            children: [
              Text(
                "Week Total :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),
            ],
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(
                value,
                sunday,
                monday,
                tuesday,
                wednesday,
                thursday,
                friday,
                saturday,
              ),
              sunAmount: value.calcuateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calcuateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calcuateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calcuateDailyExpenseSummary()[wednesday] ?? 0,
              thursAmount: value.calcuateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calcuateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calcuateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
