import 'package:expense_tracker/datetime/datetime_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  //! list of all expense
  List<ExpenseItem> overallExpenseList = [];

  //! get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //! add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
  }

  //! delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
  }

  //! get weekday from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //! get date for start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //!get todays date
    DateTime today = DateTime.now();

    //!go backwards from today to find the nearest Sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  convert overall list of expense in to daily list of summary

  e.g.
  overallExpenselist =[

  [food, 2025/2/5,$23]
  [food, 2025/2/5,$23]
  [food, 2025/2/5,$23]
  [food, 2025/2/5,$23]
  [food, 2025/2/5,$23]
  ]

  ->
  DailyExpenseSummary=[

   [2025/2/5,$23]
   [2025/2/5,$23]
   [2025/2/5,$23]
   [2025/2/5,$23]
  ]
  */

  Map<String, double> calcuateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //!date(yyyy-mm-dd):amountTotalForDay
    };
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;

        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
