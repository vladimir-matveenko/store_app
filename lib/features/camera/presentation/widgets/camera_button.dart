import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.black26,
      ),
      icon: Icon(
        icon,
        color: onPressed == null ? Colors.white38 : Colors.white,
      ),
    );
  }
}
