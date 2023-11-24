// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FollowActionCount extends StatelessWidget {
  const FollowActionCount({
    super.key,
    required this.count,
    required this.text,
  });
  final int count;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.greyScale2,
              ),
          children: [
            TextSpan(text: count.toString()),
            const TextSpan(text: " "),
            TextSpan(text: text),
          ]),
    );
  }
}
