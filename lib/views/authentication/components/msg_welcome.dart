import 'package:flutter/material.dart';

class MsgWelcome extends StatelessWidget {
  final String headlineWelcome;
  final String messageWelcome;
  const MsgWelcome(
      {super.key, required this.headlineWelcome, required this.messageWelcome});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          headlineWelcome,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          messageWelcome,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
