import 'package:devmandu/core/widgets/custom_circular_progress_widget.dart';
import 'package:flutter/material.dart';

Future<void> circularLoadingDialog(BuildContext context) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const CustomCircularProgressIndicator()),
        );
      });
}
