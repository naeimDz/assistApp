import 'package:assistantsapp/controllers/appointment_controller.dart';
import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/models/appointment.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';

class AppointScreen extends StatefulWidget {
  const AppointScreen({super.key});

  @override
  _AppointScreenState createState() => _AppointScreenState();
}

class _AppointScreenState extends State<AppointScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController =
      TextEditingController(text: "1000");
  Duration _durationHours = Duration(hours: 3.toInt()) as Duration;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final chatMessageController = ChatMessageController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Your Appointment",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDatePicker(),
            // _buildAvailableSlots(),
            _buildDurationSlider(),
            _buildDescriptionInput(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, left: 18, right: 18),
        child: Column(
          children: [
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              daysCount: 173,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedDate = date;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickertestButton() {
    return InkWell(
      onTap: () {
        // Handle date picker interaction (show date picker)
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023, 1, 1), // Adjust as needed
          lastDate:
              DateTime.now().add(const Duration(days: 365)), // Adjust as needed
        ).then((selectedDate) {
          if (selectedDate != null) {
            // Handle selected date (update state or perform actions)
            setState(() {
              print(selectedDate);
              // Update your state or logic here
            });
          }
        });
      },
      child: const Icon(
        Icons.calendar_today_outlined,
        color: AppColors.primary,
        size: 24.0,
      ),
    );
  }

  /*Widget _buildAvailableSlots() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Slots }",
            style: const TextStyle(
              color: Color.fromARGB(255, 45, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChip("Morning"),
              _buildChip("Afternoon"),
              _buildChip("Evening"),
            ],
          ),
          const SizedBox(height: 17),
          const Text(
            "Duration (hours):",
            style: TextStyle(
              color: Color.fromARGB(255, 45, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            value: _durationHours,
            min: 1.0,
            max: 12.0,
            divisions: 11,
            label: 'Duration (hours): ${_durationHours.round()}',
            onChanged: (value) {
              setState(() {
                _durationHours = value;
              });
            },
          ),
        ],
      ),
    );
  }*/

  Widget _buildDurationSlider() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Duration: (${_durationHours.inHours} hours) ",
            style: const TextStyle(
              color: Color.fromARGB(255, 45, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Slider(
              value: _durationHours.inHours.toDouble(),
              min: 1.0,
              max: 12.0,
              divisions: 11,
              label: 'Duration (hours): ${_durationHours.inHours}',
              onChanged: (value) {
                setState(() {
                  _durationHours = Duration(hours: value.toInt());
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "price",
            style: TextStyle(
              color: Color.fromARGB(255, 45, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _priceController,
            decoration: InputDecoration(
              hintText: "1000",
              border: OutlineInputBorder(),
            ),
          ),
          const Text(
            "Description",
            style: TextStyle(
              color: Color.fromARGB(255, 45, 42, 42),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Write your message...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          // Additional data input fields
          // Add your additional input fields here
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    return GestureDetector(
      onTap: () {
        final textDescription = _descriptionController.text;
        _descriptionController.clear();

        makeAppointment();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: const Center(
          child: Text(
            "Book an appointment",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void makeAppointment() {
    var assistant = Provider.of<AssistantProvider>(context, listen: false)
        .selectedAssistant;
    var currentUser = FirestoreService().auth.currentUser;
    var newAppointment = Appointment(
        assistantDisplayName: assistant?.lastName ?? assistant!.username,
        assistantEmail: assistant!.email,
        providerId: assistant.id,
        clientEmail: currentUser!.email!,
        clientDisplayName: currentUser.displayName!,
        dateTime: _selectedDate,
        duration: _durationHours,
        price: double.parse(_priceController.text),
        clientId: currentUser.uid);

    AppointmentController().createAppointment(newAppointment);
  }

  Widget _buildChip(String label) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(),
      ),
      label: Text(label),
      backgroundColor: Colors.white,
    );
  }
}
