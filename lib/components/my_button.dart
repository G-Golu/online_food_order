import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color buttonColor; // Optional, with default
  final double borderRadius; // Optional, with default

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius = 8.0, // Default value
    this.buttonColor = Colors.orangeAccent, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: buttonColor, // Use the provided button color
          borderRadius: BorderRadius.circular(borderRadius), // Use the provided borderRadius
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary, // Text color based on theme
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
