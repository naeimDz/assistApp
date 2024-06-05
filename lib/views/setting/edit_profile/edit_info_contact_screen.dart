import 'package:assistantsapp/services/firestore_service.dart';
import 'package:flutter/material.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({super.key});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _provinceController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  //final TextEditingController _zipcodeController = TextEditingController();
  late TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();
    _provinceController = TextEditingController();
    _cityController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _streetController = TextEditingController();

    // ... other initializations

    final userStream = FirestoreService().getCurrentUserDataStream();

    if (userStream != null) {
      userStream.then((snapshot) {
        if (snapshot.exists) {
          var userData = snapshot.data()!;

          _provinceController.text = userData['address']?['province'] ?? "";
          _cityController.text = userData['address']?['city'] ?? "";
          _streetController.text = userData['address']?['street'] ?? "";

          _phoneNumberController.text = userData['phoneNumber'] ?? "";
        }
      });
    }
  }

  @override
  void dispose() {
    _provinceController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  void _updateData() {
    if (_formKey.currentState!.validate()) {
      // Update data in Firestore
      var newData = {
        'address': {
          'province': _provinceController.text,
          'city': _cityController.text,
          'street': _streetController.text,
        },
        'phoneNumber': _phoneNumberController.text,
      };

      FirestoreService().updateDocument("enterprises", "", newData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Updated Successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Address Information',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _provinceController,
                decoration: const InputDecoration(
                  labelText: 'Province',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your province';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Text(
                'Phone Number',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    suffix: Icon(Icons.phone)),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
