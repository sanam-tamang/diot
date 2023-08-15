// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/features/auth/utils/validator.dart';
import 'package:flutter/material.dart';

import 'package:devmandu/features/auth/widgets/custom_tff.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
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
      textInputType: TextInputType.visiblePassword,
      validator: Validator.validatePassword,
      prefixIcon: const Icon(Icons.lock),
      obscureText: true,
    );
  }
}
