import 'package:assistantsapp/controllers/appointment_controller.dart';
import 'package:assistantsapp/controllers/assistant/assistant_provider.dart';
import 'package:assistantsapp/controllers/client/client_provider.dart';
import 'package:assistantsapp/models/appointment.dart';
import 'package:assistantsapp/models/enum/appointment_status.dart';
import 'package:assistantsapp/models/enum/role_enum.dart';
import 'package:assistantsapp/services/firestore_service.dart';
import 'package:assistantsapp/services/shared_preferences_manager.dart';
import 'package:assistantsapp/views/conversation/message_screen.dart';
import 'package:assistantsapp/views/sharedwidgets/dialog_alert_list_clients.dart';
import 'package:assistantsapp/views/sharedwidgets/make_conversation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../sharedwidgets/dialog_alert_list_assistants.dart';

class AppointScreen extends StatefulWidget {
  const AppointScreen({super.key});

  @override
  AppointScreenState createState() => AppointScreenState();
}

class AppointScreenState extends State<AppointScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController =
      TextEditingController(text: "1000");
  Duration _durationHours = Duration(hours: 3.toInt());
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
            _buildDurationSlider(),
            _buildDescriptionInput(),
            const SizedBox(height: 17),
            if (SharedPreferencesManager.getUserRole() != Role.enterprises.name)
              _buildBookButton(),
            if (SharedPreferencesManager.getUserRole() == Role.enterprises.name)
              _buildBookButtonByEnterprise(),
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

  Widget _buildDurationSlider() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Duration: (${_durationHours.inHours} hours) ",
            style: const TextStyle(
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _priceController,
            decoration: const InputDecoration(
              hintText: "1000",
              border: OutlineInputBorder(),
            ),
          ),
          const Text(
            "Description",
            style: TextStyle(
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
        ],
      ),
    );
  }

  Widget _buildBookButtonByEnterprise() {
    return GestureDetector(
      onTap: () async {
        final clientProvider =
            Provider.of<ClientProvider>(context, listen: false);
        final assistantProvider =
            Provider.of<AssistantProvider>(context, listen: false);

        if (clientProvider.selectedClient == null) {
          await showDialog(
            context: context,
            builder: (context) => DialogMakeAttendingClients(
              durationHours: _durationHours,
              priceController: _priceController.text,
              selectedDate: _selectedDate,
            ),
          );
          return;
        } else if (assistantProvider.selectedAssistant == null) {
          await showDialog(
            context: context,
            builder: (context) => DialogMakeAttendingAssistants(
              durationHours: _durationHours,
              priceController: _priceController.text,
              selectedDate: _selectedDate,
            ),
          );
          return;
        }
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

  Widget _buildBookButton() {
    return GestureDetector(
      onTap: () async {
        var dis = makeAppointment();
        DocumentReference<Object?> ref =
            await makeConversation(context, _descriptionController.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MessageScreen(conversationId: ref.id, displayName: dis!)),
        );
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

  String? makeAppointment() {
    var assistant = Provider.of<AssistantProvider>(context, listen: false)
        .selectedAssistant;
    var currentUser = FirestoreService().auth.currentUser;
    var newAppointment = Appointment(
      status: AppointmentStatus.pending,
      assistantDisplayName: assistant?.lastName ?? assistant!.userName,
      assistantEmail: assistant!.email,
      assistantId: assistant.id,
      clientEmail: currentUser!.email!,
      clientDisplayName: currentUser.displayName!,
      dateTime: _selectedDate,
      duration: _durationHours,
      price: double.parse(_priceController.text),
      clientId: currentUser.uid,
      creationDate: DateTime.now(),
    );

    AppointmentController().createAppointme(appointment: newAppointment);
    return assistant.lastName;
  }
}
