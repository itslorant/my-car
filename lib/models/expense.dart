import 'package:uuid/uuid.dart';

enum Category { maintenance, gas, other }

const uuid = Uuid();

class Expense {
  Expense({
    this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.carId,
    required this.odo,
    this.litre,
    DateTime? createdAt
  })  : id = uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String? title;
  final double price;
  final String description;
  final Category category;
  final String carId;
  final DateTime createdAt;
  final int odo;
  final double? litre;
}
