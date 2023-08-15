// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/features/auth/utils/validator.dart';
import 'package:devmandu/features/auth/widgets/custom_tff.dart';
import 'package:flutter/material.dart';


class EmailTextField extends StatelessWidget {
  const EmailTextField({
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
    return CustomTff(controller: controller, label: label, hintText: hintText,
    textInputType: TextInputType.emailAddress,
    validator: Validator.validateEmail,
    prefixIcon: const Icon(Icons.email_rounded),
    );
  }
}
