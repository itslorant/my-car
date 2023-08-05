import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:my_car/models/car.dart';
import 'package:my_car/widgets/car_image_picker.dart';

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
  File? _selectedImage;

  void _saveItem() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final uuid = Uuid();
      final carId = uuid.v4();
      
      final storageRef = FirebaseStorage.instance.ref().child('car_images').child('$carId.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      DatabaseReference databaseRef = FirebaseDatabase.instance.ref('cars').child(carId);
      await databaseRef.set({
        "id": carId,
        "brand": _enteredBrand,
        "type": _enteredType,
        "licensePlate": _enteredLicensePlate,
        "image": imageUrl
      });
      Navigator.of(context).pop(Car(
          id: '1',
          brand: _enteredBrand,
          type: _enteredType,
          licensePlate: _enteredLicensePlate,
          image: imageUrl));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add car')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(children: [
            CarImagePicker(
              onPickImage: (pickedImage) {
                _selectedImage = pickedImage;
              },
            ),
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
              textCapitalization: TextCapitalization.characters,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[A-Z0-9]*-?[A-Z0-9]*$')),
              ],
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.trim().length < 5) {
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
      ),
    );
  }
}
