import 'package:expense_tracker/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  //!reference our box
  final _myBox = Hive.box("expense_database2");

  //!write data
  void saveData(List<ExpenseItem> allExpense) {
    /*
  hive can store string and dateTime and not custom objects like ExpenseItem.
  so lets convert ExpenseItem to type that can be stored in databse

  allExpense=[
  ExpenseItem(
    title: "Groceries",
    amount: 50.0,
    dateTime: DateTime.now(),
  ),
   ->
  [name,amount dateTime ]
  */
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in allExpense) {
      //convert each item into list of storable types
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    //finally store in database
    _myBox.put("ALL_EXPENSES", allExpenseFormatted);
  }

  //!read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];

    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      //collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create expense item

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      //add expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
