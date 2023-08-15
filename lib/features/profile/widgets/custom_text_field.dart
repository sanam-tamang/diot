// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_colors.dart';

class CustomTffProfile extends StatelessWidget {
  const CustomTffProfile({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
     this.maxLength,
     this.maxLines,
   
    this.validator,
    this.textCapitalization,
    this.textInputType = TextInputType.text,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int? maxLength;
  final int? maxLines;


  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        const SizedBox(
          height: 3,
        ),
        TextFormField(
          keyboardType: textInputType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
         
         maxLength: maxLength,
         maxLines: maxLines,
          controller: controller,
          validator: validator,
     
          decoration: InputDecoration(
         
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide:const  BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black26),
                  borderRadius: BorderRadius.circular(8)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.onErrorContainer),
                  borderRadius: BorderRadius.circular(8)),
              hintText: hintText),
        ),
      ],
    );
  }
}
