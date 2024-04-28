import 'package:assistantsapp/views/sharedwidgets/build_input_text_form.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String _firstName = "";
  String _lastName = "";
  String _email = "";
  String? _gender;

  bool _hasChanges = false; // Flag to track changes

  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
                      //first name input field
                      buildInputField(
                          initialValue: _firstName,
                          labelText: "First Name",
                          prefixIcon: Icons.person_2_rounded,
                          onChanged: (p0) {
                            setState(() {
                              _firstName = p0;
                              _hasChanges = true;
                            });
                          }),
                      //last name input field
                      buildInputField(
                          initialValue: _lastName,
                          labelText: "Last Name",
                          prefixIcon: Icons.person_2_rounded,
                          onChanged: (p0) {
                            setState(() {
                              _lastName = p0;
                              _hasChanges = true;
                            });
                          }),
                      //emailinput field
                      buildInputField(
                        initialValue: _email,
                        labelText: "Email",
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your email" : null,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                            _hasChanges = true;
                          });
                        },
                      ),
                      //dropdown form input  gender
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonFormField<String>(
                          value: "Man",
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty
                              ? "make sure choose your gender"
                              : null,
                          onChanged: (value) {
                            print(_gender);
                            _gender = value;
                            _hasChanges = true;
                          },
                          // Set initial value or null
                          items: ['Man', 'Woman']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Save Button with change detection
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _hasChanges
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            // Save profile information (implement API call or local storage)
                            print("Profile saved!");
                            setState(() {
                              _hasChanges = false;
                            });
                          }
                        }
                      : null, // Disable button if no changes
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
