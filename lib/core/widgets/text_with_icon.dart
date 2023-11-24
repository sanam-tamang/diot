// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    super.key,
    required this.text,
    required this.icon,
    this.color = Colors.black,
    this.center = false,
  });
  final String text;
  final IconData icon;
  final Color color;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(color: color),
        ),
        const SizedBox(
          width: 5,
        ),
        FaIcon(
          icon,
          color: color,
        ),
      ],
    );
  }
}
