import 'package:my_car/models/expense.dart';

final expenses = [
  Expense(
      id: 'expense0',
      title: 'Oil Change',
      price: 136.79,
      description: 'Routine maintenance for your vehicle',
      category: Category.maintenance,
      carId: '1',
      createdAt: DateTime.now(),
      odo: 110500),
  Expense(
      id: 'expense4',
      title: 'Tire Change',
      price: 136.79,
      description: 'Routine maintenance for your tires',
      category: Category.maintenance,
      carId: '1',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      odo: 110000),
  Expense(
      id: 'expense1',
      title: 'Car Wash',
      price: 429.90,
      description: 'Keep your car looking clean and shiny',
      category: Category.other,
      carId: '1',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      odo: 110000),
  Expense(
      id: 'expense2',
      title: 'Break Check',
      price: 201.67,
      description: 'Ensure your brakes are in good condition',
      category: Category.maintenance,
      carId: '2',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      odo: 110000),
  Expense(
      id: 'expense3',
      title: 'Tire Rotation',
      price: 116.36,
      description: 'Extend the life of your tires by rotating them',
      category: Category.maintenance,
      carId: '2',
      createdAt: DateTime.now(),
      odo: 110000),
];
