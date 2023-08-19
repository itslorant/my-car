import 'package:flutter/material.dart';

import 'package:my_car/data/dummy_expenses.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/models/expense.dart';
import 'package:my_car/models/gas_expense.dart';
import 'package:my_car/screens/new_expense.dart';
import 'package:my_car/widgets/expense_item.dart';
import 'package:my_car/widgets/gas_expense_item.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key, required this.car});
  final Car car;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  IconData _getIcon(int pageIdx) {
    switch (pageIdx) {
      case 1:
        return Icons.water_drop;
      case 2:
        return Icons.add_chart;
      default:
        return Icons.car_crash;
    }
  }

  _addExpense() async {
    final newExpense = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewExpenseScreen(
              carId: widget.car.id,
            )));
    print(newExpense);
    if (newExpense != null) {
      setState(() {
        expenses.add(newExpense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Expense> filteredExpenses = expenses
        .where((expense) =>
            expense.carId == widget.car.id &&
            expense.category.index == _selectedPageIndex)
        .toList();
    filteredExpenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      appBar: AppBar(title: Text(widget.car.licensePlate), actions: [
        GestureDetector(
          onTap: _addExpense,
          child: const Icon(Icons.add),
        )
      ]),
      body: ListView.builder(
        padding: const EdgeInsets.all(7),
        itemCount: filteredExpenses.length,
        itemBuilder: (context, index) => Stack(
          children: [
            _selectedPageIndex == 1
                ? GasExpenseItem(expense: filteredExpenses[index] as GasExpense)
                : ExpenseItem(expense: filteredExpenses[index]),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: Icon(
                _getIcon(_selectedPageIndex), size: 15,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => _selectPage(index),
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash), label: 'Maintenance'),
            BottomNavigationBarItem(
                icon: Icon(Icons.gas_meter), label: 'Gas fill'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_chart), label: 'Other'),
          ]),
    );
  }
}
