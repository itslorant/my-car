class Expense {

  Expense({
    required this.id, required this.title, required this.price, required this.description, required this.carId
  });

  final String id;
  final String title;
  final double price;
  final String description;
  final String carId;
}