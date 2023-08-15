import 'package:flutter/material.dart';

void dialogMessage(BuildContext context,
    {required String title, required String content}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          title: Text(title),
          content: SizedBox(child: Text(content)),
        );
      });
}


