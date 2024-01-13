import 'package:expense_tracker/widgtes/chart/chart.dart';
import 'package:expense_tracker/widgtes/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgtes/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

@override
  State<StatefulWidget> createState(){
  return _ExpensesState();

}
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [];
  
  void _openAddExpenseOverlay(){
    showModalBottomSheet(useSafeArea:true,isScrollControlled:true,
      context: context, builder: (ctx) =>
           NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex,expense);
          });
        }),
        content: const Text('Expense Deleted') ,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(child:
    Text('No Expenses found, Start Adding Some'),
    );

     if(_registeredExpenses.isNotEmpty){
       mainContent = ExpensesList(expenses: _registeredExpenses,
         onRemoveExpense: _removeExpense,);
     }

    return  Scaffold(
      appBar: AppBar(
        title: const Text('FlutterExpenseTracker'),
          actions: [
            IconButton(onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses:_registeredExpenses),
           Expanded(
               child : mainContent,
            ),
        ],
      ):Row(children: [
          Expanded(child: Chart(expenses:_registeredExpenses),
        ),
        Expanded(
          child : mainContent,
        ),
      ],)
    );
  }
}