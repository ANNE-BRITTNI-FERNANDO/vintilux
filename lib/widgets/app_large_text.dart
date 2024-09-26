import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;

  // Constructor with named optional parameters
  const AppLargeText({
    super.key,
    this.size = 30,  // Default size
    required this.text,
    this.color = Colors.black,  // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
