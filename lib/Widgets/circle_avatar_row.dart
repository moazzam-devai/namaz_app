import 'package:flutter/material.dart';

class CircleAvatarRow extends StatelessWidget {
  final List<AvatarData> avatars;

  const CircleAvatarRow({super.key, required this.avatars});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: avatars.map((avatar) {
        return GestureDetector(
          onTap: avatar.onTap,
          child: CircleAvatar(
            backgroundColor: const Color(0xFF222933),
            radius: avatar.radius,
            backgroundImage: AssetImage(avatar.imagePath),
          ),
        );
      }).toList(),
    );
  }
}

class AvatarData {
  final String imagePath;
  final VoidCallback onTap;

  final double radius;

  AvatarData({
    required this.imagePath,
    required this.onTap,
    required this.radius,
  });
}
