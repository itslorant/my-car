import 'dart:io';

import 'package:flutter/material.dart';

class Cars extends StatelessWidget {
  const Cars({super.key});

  final carList = const [
    {'id': 1, 'brand': 'Opel', 'type': 'Astra', 'licensePlateNr': 'JEF-399'},
    {'id': 2, 'brand': 'Skoda', 'type': 'Octavia', 'licensePlateNr': 'RHK-901'},
    {'id': 3, 'brand': 'VW', 'type': 'Touran', 'licensePlateNr': 'OFOW72'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My cars')),
        body: ListView.builder(
          itemCount: carList.length,
          itemBuilder: (context, index) => Card(
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
                      Text(
                          '${carList[index]['brand']} ${carList[index]['type']}'),
                      Text('${carList[index]['licensePlateNr']}'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
