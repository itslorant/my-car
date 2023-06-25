import 'package:my_car/models/expense.dart';

class GasExpense extends Expense {
  GasExpense(
      {required id,
      required title,
      required price,
      required description,
      required category,
      required carId,
      required createdAt,
      required odo,
      required this.litre})
      : super(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            carId: carId,
            createdAt: createdAt,
            odo: odo);

  final double litre;
}
