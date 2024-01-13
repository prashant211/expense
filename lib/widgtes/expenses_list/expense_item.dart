import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem({required this.expense,super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
          
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
          const SizedBox(height:4),
          Row(
            children: [
              //toStringAsFixed means it
              // will print the fixed no of numbers after the decimal point
              //second dollar sign represent to injection
              Text('\$ ${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(children: [
                        Icon(categoryIcons[expense.category]),
               const  SizedBox(width: 8),
                Text(expense.formattedDate),
              ],
              ),
            ],
          ),
        ],) ,
      ),
    );
  }
  
}