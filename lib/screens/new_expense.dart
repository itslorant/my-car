import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_car/models/expense.dart';
import 'package:my_car/models/gas_expense.dart';

class NewExpenseScreen extends StatefulWidget {
  const NewExpenseScreen({super.key, required this.carId});

  final String carId;
  @override
  State<NewExpenseScreen> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpenseScreen> {
  final List<Category> categories = Category.values.toList();
  final _formkey = GlobalKey<FormState>();
  Category _selectedCategory = Category.other;
  var _enteredTitle = '';
  var _enteredPrice = 0.0;
  var _enteredOdo = 0;
  var _enteredDescription = '';
  var _enteredLitre = 0.0;

  void _saveExpense() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      if (_selectedCategory == Category.gas) {
        Navigator.of(context).pop(GasExpense(
            id: 'ge5',
            title: _enteredTitle,
            price: _enteredPrice,
            description: _enteredDescription,
            category: _selectedCategory,
            carId: widget.carId,
            createdAt: DateTime.now(),
            odo: _enteredOdo,
            litre: _enteredLitre));
      }
      Navigator.of(context).pop(Expense(
          id: 'e5',
          title: _enteredTitle,
          price: _enteredPrice,
          description: _enteredDescription,
          category: _selectedCategory,
          carId: widget.carId,
          createdAt: DateTime.now(),
          odo: _enteredOdo));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New expense')),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: _selectedCategory,
                    decoration: const InputDecoration(label: Text('Category')),
                    items: [
                      for (final category in categories)
                        DropdownMenuItem(
                            value: category, child: Text(category.name))
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(label: Text('Title')),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 3) {
                        return 'Please enter at least 3 character.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredTitle = value!;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(label: Text('Price')),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$')),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field can not be empty.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredPrice = double.parse(value!);
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(label: Text('ODO')),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field can not be empty.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredOdo = int.parse(value!);
                      });
                    },
                  ),
                  if (_selectedCategory == Category.gas)
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}$')),
                      ],
                      decoration: const InputDecoration(label: Text('Litre')),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field can not be empty.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _enteredLitre = double.parse(value!);
                        });
                      },
                    ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(label: Text('Description')),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredDescription = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: _saveExpense,
                      icon: const Icon(Icons.add),
                      label: const Text('Add'))
                ],
              ))),
    );
  }
}
