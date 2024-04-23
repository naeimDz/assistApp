import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _name = "";
  String _email = "";
  String _sex = "";
  String _country = "";
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
                // Profile Picture with Edit Icon
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            print("Edit Picture"), // Implement image picking
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Basic Information Section
                ProfileSection(
                  title: "Basic Information",
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(labelText: "Name"),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your name" : null,
                        onChanged: (value) => setState(() {
                          _name = value;
                          _hasChanges = true;
                        }),
                      ),
                      TextFormField(
                        initialValue: _email,
                        decoration: InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your email" : null,
                        onChanged: (value) => setState(() {
                          _email = value;
                          _hasChanges = true;
                        }),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Sex',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        value: null, // Set initial value or null
                        onChanged: (String? newValue) {
                          // Handle sex selection
                        },
                        items: ['Man', 'Woman']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
