import 'package:flutter/material.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/screens/car_detail.dart';

class CarsList extends StatelessWidget {
  const CarsList({super.key, required this.carList});

  final List<Car> carList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CarDetailScreen(car: carList[index]),
          ),
        ),
        child: Card(
          margin: const EdgeInsets.all(7),
          color: Colors.green[50],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Image.network(carList[index].image,
                  width: double.infinity, height: 150, fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${carList[index].brand} ${carList[index].type}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(carList[index].licensePlate,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
