import 'package:assistantsapp/models/enum/service_type.dart';
import 'package:assistantsapp/utils/routes/route_name_strings.dart';
import 'package:assistantsapp/views/sharedwidgets/tags_input.dart';
import 'package:flutter/material.dart';
import '../../../models/enum/gender.dart';
import '../../../services/firestore_service.dart';
import '../../../services/shared_preferences_manager.dart';

class EditAssistantProfileView extends StatefulWidget {
  const EditAssistantProfileView({super.key});

  @override
  EditAssistantProfileViewState createState() =>
      EditAssistantProfileViewState();
}

class EditAssistantProfileViewState extends State<EditAssistantProfileView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  String _selectedGender = Gender.man.name;

  late List<String> _tags;
  late TextEditingController _birthdayController;
  late TextEditingController _phoneNumberController;
  final TextEditingController _skillsController =
      TextEditingController(text: "");
  late String? selectedService = ServiceType.childCare.name;
  // bool _hasChanges = false; // Flag to track changes

  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _birthdayController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _tags = [];
    // ... other initializations

    final userStream = FirestoreService().getCurrentUserDataStream();
    if (userStream != null) {
      userStream.then((snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data()!;
          _firstNameController.text = userData['firstName'] as String? ?? "";
          _lastNameController.text = userData['lastName'] as String? ?? "";
          _selectedGender = userData['gender'] as String? ?? Gender.man.name;
          _birthdayController.text = userData['birthday'] ?? "";
          _phoneNumberController.text =
              userData['phoneNumber'] as String? ?? "";
          selectedService = userData['serviceType'] as String;
          List<dynamic> listDtataofSkills = userData['skillsList'];
          for (var element in listDtataofSkills) {
            _tags.add(element.toString());
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();

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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
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
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    value: _selectedGender,
                    items: Gender.values
                        .map((gender) => DropdownMenuItem(
                              value: gender.name,
                              child: Text(gender.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
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
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Service type",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your Service type';
                      }
                      return null;
                    },
                    value: selectedService,
                    items: ServiceType.values
                        .map((type) => DropdownMenuItem(
                              value: type.name,
                              child: Text(type.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedService = value;
                      });
                    },
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
                      } else if (!RegExp(r'^\+?[0-9]{10,15}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  TagsInput(
                    textController: _skillsController,
                    tags: _tags,
                  ),
                  ElevatedButton(
                    onLongPress: () => print(_tags.toString()),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String role = SharedPreferencesManager.getUserRole();
                        String id = FirestoreService().auth.currentUser!.uid;
                        var data = {
                          "firstName": _firstNameController.text,
                          "lastName": _lastNameController.text,
                          "gender": _selectedGender,
                          "birthday": _birthdayController.text,
                          "serviceType": selectedService,
                          "skillsList": _tags,
                          "phoneNumber": _phoneNumberController.text
                        };
                        // Process data

                        FirestoreService().updateDocument(role, id, data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('update !')),
                        );
                        Navigator.popAndPushNamed(
                            context, RouteNameStrings.homeScreen);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ]),
              ),
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
