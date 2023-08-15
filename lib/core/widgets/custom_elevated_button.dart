// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            foregroundColor:
                foregroundColor ?? Theme.of(context).colorScheme.onPrimary),
        onPressed: onPressed,
        child: Text(label));
  }
}
