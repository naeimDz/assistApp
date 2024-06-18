import 'package:flutter/material.dart';

class BuildTestAd extends StatelessWidget {
  const BuildTestAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: const Center(
        child: Text(
          'Test Ad',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
    ;
  }
}
