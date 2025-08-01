import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new Expenses"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(hintText: 'Your Expense'),
            ),

            //expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
          ],
        ),
        actions: [
          //save button
          MaterialButton(onPressed: save, child: Text('save')),

          //cancel button
          MaterialButton(onPressed: cancel, child: Text('cancel')),
        ],
      ),
    );
  }

  //save method
  void save() {
    //create new expense item

    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    //add new Expense

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  //cancel method
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            SizedBox(height: 20),

            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
