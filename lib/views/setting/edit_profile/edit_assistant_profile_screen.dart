import 'package:flutter/material.dart';

import '../../../services/firestore_service.dart';

class EditAssistantProfileView extends StatefulWidget {
  const EditAssistantProfileView({super.key});

  @override
  EditAssistantProfileViewState createState() =>
      EditAssistantProfileViewState();
}

class EditAssistantProfileViewState extends State<EditAssistantProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;
  late TextEditingController _phoneNumberController;

  // bool _hasChanges = false; // Flag to track changes

  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _birthdayController = TextEditingController();
    _phoneNumberController = TextEditingController();

    // ... other initializations

    final userStream = FirestoreService().getCurrentUserDataStream();
    if (userStream != null) {
      userStream.then((snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data()!;
          _firstNameController.text = userData['firstName'] as String;
          _lastNameController.text = userData['lastName'] as String;
          _genderController.text = userData['gender'] as String;
          _birthdayController.text = userData['birthDay'] as String;
          _phoneNumberController.text = userData['phoneNumber'] as String;
        }
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Padding(
            padding: EdgeInsets.all(17),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'firstName',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your firstName';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _firstNameController.text = value!;
                  },
                ),
                SizedBox(height: 16),
              ]),
            )));
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ProfileSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        child,
      ],
    );
  }
}
