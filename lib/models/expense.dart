//model or date model how the datat will look
 import 'package:flutter/material.dart';
//for unique id generation
import 'package:uuid/uuid.dart';
//for formatting date and time
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

//using uuid flutter package to generate
// the unique id always when new data is added
const uuid =  Uuid();
//enum helps us to create a list of the values we
// want to show or common values or strings or we can say the option
enum Category{
  food,travel,leisure,work
}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work,
};
class Expense {
  Expense({required this.title,
  required this.amount,
    required this.date,
    required
    this.category
  }) : id = uuid.v4();

     final String id;
     final String title;
     final double amount;
     final DateTime date;
     final Category category;

     String get formattedDate{

       //for formatting date and time we will
       // use the third party package intl
       return formatter.format(date);
     }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category
      ) : expenses =  allExpenses.where((
      expense) => expense.category == category).toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for(final expense in expenses){
        sum += expense.amount;
    }
    return sum;
  }
}