import 'package:assistantsapp/models/enum/gender.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:flutter/material.dart';

import '../../../services/firestore_service.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _birthdayController;
  String? _selectedGender;
  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    // _genderController = TextEditingController();
    _birthdayController = TextEditingController();

    // ... other initializations

    final userStream = FirestoreService().getCurrentUserDataStream();

    if (userStream != null) {
      userStream.then((snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data()!;

          // Convert Timestamp to DateTime

          _firstNameController.text = userData['firstName'] as String;
          _lastNameController.text = userData['lastName'] as String;
          _selectedGender = userData['gender'] as String;
          // Use Utils class for formatting (replace 'dd MMM yyyy' with your desired format)
          _birthdayController.text = userData['birthday'];
        }
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    //  _genderController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                value: _selectedGender,
                items: Gender.values
                    .map((gender) => DropdownMenuItem(
                          value: gender.name,
                          child: Text(gender.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdayController,
                decoration: const InputDecoration(
                  labelText: 'Birthday',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    //initialDate: DateTime.now(),
                    firstDate: DateTime(1954),
                    lastDate: DateTime(2004),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _birthdayController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your birthday';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String role = SharedPreferencesManager.getUserRole();
                    String id = FirestoreService().auth.currentUser!.uid;
                    var data = {
                      "firstName": _firstNameController.text,
                      "lastName": _lastNameController.text,
                      "gender": _selectedGender,
                      "birthday": _birthdayController.text
                    };
                    // Process data

                    FirestoreService().updateDocument(role, id, data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('update !')),
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
