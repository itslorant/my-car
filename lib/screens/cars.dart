import 'package:flutter/material.dart';
import 'package:my_car/models/car.dart';
import 'package:my_car/screens/add_car.dart';
import 'package:my_car/screens/car_detail.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsState();
}

class _CarsState extends State<CarsScreen> {
  final List<Car> carList = [
    // const Car(id: '1', brand: 'Opel', type: 'Astra', licensePlate: 'JEF-399'),
    // const Car(
    //     id: '2', brand: 'Skoda', type: 'Octavia', licensePlate: 'RHK-901'),
    // const Car(id: '3', brand: 'VW', type: 'Touran', licensePlate: 'OFOW72'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My cars'), actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () async {
              final car = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddCar(),
              ));
              if (car != null) {
                setState(() {
                  carList.add(car);
                });
              }
            },
          )
        ]),
        body: ListView.builder(
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  Image.file(carList[index].image,
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
                          Text('${carList[index].brand} ${carList[index].type}', style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                          Text(carList[index].licensePlate, style: const TextStyle(
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
        ));
  }
}
