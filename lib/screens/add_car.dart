import 'package:flutter/material.dart';

class AddCar extends StatelessWidget {
  const AddCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add car')),
      body: Column(children: const [
        TextField(
          decoration: InputDecoration(label: Text('Brand')),
        ),
        TextField(
          decoration: InputDecoration(label: Text('Type')),
        ),
        TextField(
          decoration: InputDecoration(label: Text('License plate')),
          autocorrect: false,
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: null, child: Text('Add car')),
      ]),
    );
  }
}
