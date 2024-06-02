import 'package:flutter/material.dart';

Widget circleAvatar(String? url, String? naame, {double radius = 50}) {
  return CircleAvatar(
    radius: radius,
    //backgroundColor: Colors.grey.shade200, // Default background color
    backgroundImage: url?.isNotEmpty ?? false ? NetworkImage(url!) : null,
    child: Text(
      url?.isEmpty ?? naame?.isNotEmpty ?? false
          ? naame![0].toUpperCase() // Get first letter (uppercase)
          : '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
