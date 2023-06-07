import 'package:flutter/material.dart';
import 'package:my_car/models/car.dart';
import 'package:my_car/screens/add_car.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final List<Car> carList = [
    const Car(id: '1', brand: 'Opel', type: 'Astra', licensePlate: 'JEF-399'),
    const Car(
        id: '2', brand: 'Skoda', type: 'Octavia', licensePlate: 'RHK-901'),
    const Car(id: '3', brand: 'VW', type: 'Touran', licensePlate: 'OFOW72'),
  ];

  @override
  Widget build(BuildContext context) {
    print('render');
    print(carList.length);
    return Scaffold(
        appBar: AppBar(title: const Text('My cars'), actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddCar(),
              ));
            },
          )
        ]),
        body: ListView.builder(
          itemCount: carList.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.all(7),
            color: Colors.green[50],
            child: Column(
              children: [
                Image.asset('assets/images/vintage-car.png', height: 150),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      gradient:
                          LinearGradient(colors: [Colors.white, Colors.green])),
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${carList[index].brand} ${carList[index].type}'),
                      Text(carList[index].licensePlate),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
