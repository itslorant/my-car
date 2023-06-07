import 'package:flutter/material.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/models/expense.dart';

class CarDetailScreen extends StatelessWidget {
  CarDetailScreen({super.key, required this.car});
  final Car car;

  final List<Expense> expenses = [
    Expense(id: 'e-1', title: 'Oil change', price: 35.44, description: '5W40'),
    Expense(
        id: 'e-2',
        title: 'Car wash',
        price: 12.00,
        description: 'Cleaner than ever'),
  ];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(title: Text(car.licensePlate), actions: [
          GestureDetector(
            onTap: null,
            child: const Icon(Icons.add),
          )
        ]),
        body: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) => Card(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5,),
                            Text(expenses[index].description),
                          ],
                        ),
                        Text(expenses[index].price.toString()),
                      ],
                    ),
                  ]),
                )));
  }
}
