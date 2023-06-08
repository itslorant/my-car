import 'package:flutter/material.dart';
import 'package:my_car/data/dummy_expenses.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/models/expense.dart';

class CarDetailScreen extends StatelessWidget {
  CarDetailScreen({super.key, required this.car});
  final Car car;


  @override
  Widget build(BuildContext context) {
    final List<Expense> filteredExpenses =
      expenses.where((expense) => expense.carId == car.id).toList();

    return Scaffold(
        appBar: AppBar(title: Text(car.licensePlate), actions: [
          GestureDetector(
            onTap: null,
            child: const Icon(Icons.add),
          )
        ]),
        body: ListView.builder(
            itemCount: filteredExpenses.length,
            itemBuilder: (context, index) => Card(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredExpenses[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(filteredExpenses[index].description),
                          ],
                        ),
                        Text(filteredExpenses[index].price.toString()),
                      ],
                    ),
                  ]),
                )));
  }
}
