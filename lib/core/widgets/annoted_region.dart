// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAnnotatedRegion extends StatelessWidget {
  const CustomAnnotatedRegion({
    Key? key,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);
  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: color,
      ),
      child: child,
    );
  }
}
