import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/screens/add_car.dart';
import 'package:my_car/widgets/cars_list.dart';

final _firebaseAuth = FirebaseAuth.instance;
class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsState();
}

class _CarsState extends State<CarsScreen> {
  List<Car> carList = [];
  Future<void> _getCars() async {
    carList.clear();
    final userId = _firebaseAuth.currentUser!.uid;
    final databaseRef = FirebaseDatabase.instance.ref('cars').child(userId);
    DataSnapshot snapshot = await databaseRef.get();
    for (final car in snapshot.children) {
      final id = car.child('id').value.toString();
      final brand = car.child('brand').value.toString();
      final image = car.child('image').value.toString();
      final licensePlate = car.child('licensePlate').value.toString();
      final type = car.child('type').value.toString();
      carList.add(Car(
          id: id,
          brand: brand,
          image: image,
          licensePlate: licensePlate,
          type: type));
    }
  }

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
      
      body: FutureBuilder(
        future: _getCars(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CarsList(
                    carList: carList,
                  ),
      ),
    );
  }
}
