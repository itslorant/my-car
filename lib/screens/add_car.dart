import 'package:flutter/material.dart';

import 'package:my_car/models/car.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formkey = GlobalKey<FormState>();
  var _enteredBrand = '';
  var _enteredType = '';
  var _enteredLicensePlate = '';

  void _saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.of(context).pop(Car(
          id: '4',
          brand: _enteredBrand,
          type: _enteredType,
          licensePlate: _enteredLicensePlate));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add car')),
      body: Form(
        key: _formkey,
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Brand')),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field must not be empty.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredBrand = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Type')),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field must not be empty.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredType = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('License plate')),
            autocorrect: false,
            validator: (value) {
              if (value == null || value.trim().isEmpty || value.trim().length < 5) {
                return 'Must have at least 5 characters.';
              }
              return null;
            },
            onSaved: (value) {
              _enteredLicensePlate = value!;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: _saveItem, child: const Text('Add car')),
        ]),
      ),
    );
  }
}
