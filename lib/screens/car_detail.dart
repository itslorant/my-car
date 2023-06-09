import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_car/data/dummy_expenses.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/models/expense.dart';
import 'package:my_car/screens/new_expense.dart';

class CarDetailScreen extends StatefulWidget {
  CarDetailScreen({super.key, required this.car});
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

  _addExpense() async {
    final newExpense = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewExpenseScreen(
              carId: widget.car.id,
            )));
    setState(() {
      expenses.add(newExpense);
    });
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
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.amber,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filteredExpenses[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('${filteredExpenses[index].odo.toString()} km'),
                  Text(
                    '${filteredExpenses[index].price.toString()} €',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(filteredExpenses[index].description),
                  Text(DateFormat.yMd()
                      .addPattern(DateFormat.HOUR24_MINUTE)
                      .format(filteredExpenses[index].createdAt.toLocal())),
                ],
              )
            ]),
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
