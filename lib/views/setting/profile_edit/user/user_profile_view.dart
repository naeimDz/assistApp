import 'package:flutter/material.dart';

import '../../../../services/firestore_service.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;

  bool _hasChanges = false; // Flag to track changes

  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _birthdayController = TextEditingController();

    // ... other initializations

    final userStream = FirestoreService().getCurrentUserDataStream();
    if (userStream != null) {
      userStream.listen((snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data()!;
          _firstNameController.text = userData['firstName'] as String;
          _lastNameController.text = userData['lastName'] as String;
          _genderController.text = userData['gender'] as String;
          _birthdayController.text = userData['birthDay'] as String;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Basic Information Section
                ProfileSection(
                  title: "Basic Information",
                  child: Column(
                    children: [
                      // First Name Text Field
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasChanges = true;
                          });
                        },
                      ),

                      // Last Name Text Field
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasChanges = true;
                          });
                        },
                      ),

                      // Gender Text Field
                      TextFormField(
                        controller: _genderController,
                        decoration: InputDecoration(
                          labelText: "Gender",
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasChanges = true;
                          });
                        },
                      ),

                      TextFormField(
                        controller: _birthdayController,
                        decoration: InputDecoration(
                          labelText: "Birthday",
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1996),
                                lastDate: DateTime(2002),
                              );

                              if (selectedDate != null) {
                                setState(() {
                                  _birthdayController.text =
                                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                                  _hasChanges = true;
                                });
                              }
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasChanges = true;
                          });
                        },
                      )
                    ],
                  ),
                ),

                // Save Button with change detection
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _hasChanges
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            // Save profile information
                            updateUserProfile();
                          }
                        }
                      : null,
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to update user profile
  void updateUserProfile() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String gender = _genderController.text;
    String birthday = _birthdayController.text;

    // Update user object with new data
    var updatedData = {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "birthday": birthday,
      // Populate other user properties as needed
    };

    // Call user controller provider to update user data
    //UserControllerProvider().updateUser(updatedUser);

    // Reset flag and show success message or handle navigation
    setState(() {
      _hasChanges = false;
    });
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
