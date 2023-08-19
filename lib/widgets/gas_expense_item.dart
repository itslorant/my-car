import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_car/models/expense.dart';

class GasExpenseItem extends StatelessWidget {
  const GasExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.amber,
        child: Container(
          margin:
              const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${expense.litre.toString()} litres',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${expense.odo.toString()} km'),
                  Text(
                    '${expense.price.toString()} €',
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
                  Text(expense.description),
                  Text(DateFormat("dd.MM.yyyy")
                      .addPattern(DateFormat.HOUR24_MINUTE)
                      .format(expense.createdAt.toLocal())),
                ],
              )
            ],
          ),
        ));
  }
}
