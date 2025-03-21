import 'package:flutter/material.dart';

class ContainerWithImage extends StatelessWidget {
  final double height;
  final String imagePath;
  final BorderRadius borderRadius;

  const ContainerWithImage({
    super.key,
    required this.height,
    required this.imagePath,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}

class SimpleContainer extends StatelessWidget {
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const SimpleContainer({
    super.key,
    required this.height,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
    );
  }
}

class ContainerWithShadow extends StatelessWidget {
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const ContainerWithShadow({
    super.key,
    required this.height,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2), // Shadow color
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
