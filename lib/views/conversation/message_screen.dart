import 'package:assistantsapp/controllers/conversations/message_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/message.dart';
import '../../services/firestore_service.dart';

class MessageScreen extends StatelessWidget {
  final String conversationId;

  MessageScreen({required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return SizedBox();

    /*Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: conversationRef?.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!.docs
              .map((doc) => Message.fromJson(doc.data()!))
              .toList();

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return SizedBox(); // Replace with your message widget
            },
          );
        },
      ),
    );*/
  }
}

class _MessageInputField extends StatefulWidget {
  final String conversationId;

  _MessageInputField({required this.conversationId});

  @override
  __MessageInputFieldState createState() => __MessageInputFieldState();
}

class __MessageInputFieldState extends State<_MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final newMessage = Message(
        content: _controller.text,
        senderUid: Provider.of<FirestoreService>(context, listen: false)
            .auth
            .currentUser!
            .uid,
        timestamp: Timestamp.now(),
      );

      Provider.of<MessageController>(context, listen: false)
          .addMessage(widget.conversationId, newMessage);

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
