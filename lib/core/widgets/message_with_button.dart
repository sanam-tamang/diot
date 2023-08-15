// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageWithButton extends StatelessWidget {
  const MessageWithButton({
    Key? key,
    required this.message,
    required this.navigateTo,
    required this.routeName,
    this.afterRoute,
  }) : super(key: key);
  final String message;
  final VoidCallback navigateTo;
  final String routeName;
  final String? afterRoute;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      spacing: -8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(message),
        TextButton(onPressed: navigateTo, child: Text(routeName)),
              Text(afterRoute??''),

      ],
    );
  }
}
