import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color color; // Button color
  final double borderRadius; // Border radius

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.color = Colors.green, // Default button color
    this.borderRadius = 12.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: Color(0xFF222933),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold), // White text
        ),
      ),
    );
  }
}
