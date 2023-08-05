import 'dart:io';

class Car {
  const Car({
    required this.id,
    required this.brand,
    required this.type,
    required this.licensePlate,
    required this.image
  });

  final String id;
  final String brand;
  final String type;
  final String licensePlate;
  final String image;
}