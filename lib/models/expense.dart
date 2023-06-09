enum Category { maintenance, gas, other }

class Expense {
  Expense(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.carId,
      required this.createdAt,
      required this.odo});

  final String id;
  final String title;
  final double price;
  final String description;
  final Category category;
  final String carId;
  final DateTime createdAt;
  final int odo;
}
