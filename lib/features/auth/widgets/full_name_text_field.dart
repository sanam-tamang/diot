// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/features/auth/utils/validator.dart';
import 'package:devmandu/features/auth/widgets/custom_tff.dart';
import 'package:flutter/material.dart';

class FullNameTextField extends StatelessWidget {
  const FullNameTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return CustomTff(
      controller: controller,
      label: label,
      hintText: hintText,
      textInputType: TextInputType.text,
      validator: Validator.validateFullName,
      textCapitalization: TextCapitalization.words,
      prefixIcon: const Icon(Icons.person),
    );
  }
}
