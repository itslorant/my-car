import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/models/expense.dart';
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
  final List<Expense> _expenses = [];
  List<Expense> _filteredExpenses = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    _filterExpenses();
  }

  IconData _getIcon(int pageIdx) {
    switch (pageIdx) {
      case 0:
        return Icons.car_crash;
      case 1:
        return Icons.water_drop;
      case 2:
        return Icons.add_chart;
      default:
        return Icons.car_crash;
    }
  }

  int _getPageIndexByCategory(Category category) {
    switch (category) {
      case Category.maintenance:
        return 0;
      case Category.gas:
        return 1;
      case Category.other:
        return 2;
      default:
        return 0;
    }
  }

  Future<void> _fetchExpenses() async {
    _expenses.clear();
    final databaseRef = FirebaseDatabase.instance
        .ref('expenses').child(widget.car.id);
    DataSnapshot snapshot = await databaseRef.get();
    for (final expense in snapshot.children) {
      final title = expense.child('title').value.toString();
      final price = expense.child('price').value.toString();
      final description = expense.child('description').value.toString();
      final category = expense.child('category').value.toString();
      final carId = expense.child('carId').value.toString();
      final odo = expense.child('odo').value.toString();
      final litre = expense.child('litre').value.toString();
      final createdAt = expense.child('createdAt').value.toString();
      Category cat =
          Category.values.firstWhere((c) => c.toString() == category);
      _expenses.add(
        Expense(
            title: title,
            price: double.parse(price),
            description: description,
            category: cat,
            carId: carId,
            odo: int.parse(odo),
            litre: double.parse(litre),
            createdAt: DateTime.parse(createdAt)),
      );
    }
    _expenses.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _filterExpenses();
  }

  _addExpense() async {
    final newExpense =
        await Navigator.of(context).push(MaterialPageRoute<Expense>(
            builder: (context) => NewExpenseScreen(
                  carId: widget.car.id,
                )));
    if (newExpense != null) {
      setState(() {
        _selectedPageIndex = _getPageIndexByCategory(newExpense.category);
        _expenses.add(newExpense);
      });
    }
  }

  void _filterExpenses() {
    _filteredExpenses = _expenses
        .where((expense) => expense.category.index == _selectedPageIndex)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.car.licensePlate), actions: [
        GestureDetector(
          onTap: _addExpense,
          child: const Icon(Icons.add),
        )
      ]),
      body: FutureBuilder(
        future: _fetchExpenses(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(7),
                    itemCount: _filteredExpenses.length,
                    itemBuilder: (context, index) => Stack(
                      children: [
                        _selectedPageIndex == 1
                            ? GasExpenseItem(expense: _filteredExpenses[index])
                            : ExpenseItem(expense: _filteredExpenses[index]),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                          child: Icon(
                            _getIcon(_selectedPageIndex),
                            size: 15,
                          ),
                        ),
                      ],
                    ),
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
