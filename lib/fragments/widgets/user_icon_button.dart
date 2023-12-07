import 'package:flutter/material.dart';

import '../buttons.dart';

class UserIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UserIconButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CircleButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF404040),
        icon: const Icon(Icons.person, size: 30),
        mini: true,
        onPressed: onPressed,
      );
}
