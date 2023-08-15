// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CustomQuillEditor extends StatelessWidget {
  const CustomQuillEditor({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onTap,
    this.showCursor = true,
    required this.focusNode,
  }) : super(key: key);
  final QuillController controller;
  final String hintText;
  final VoidCallback onTap;
  final bool showCursor;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      onTapDown: (details, p1) {
        onTap();
        return false;
      },
      onTapUp: (details, p1) {
        onTap();
        return false;
      },
      controller: controller,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: focusNode,
      autoFocus: false,
      readOnly: false,
      expands: false,
      showCursor: showCursor,
      placeholder: hintText,
      padding: EdgeInsets.zero,
      keyboardAppearance: Brightness.light,
      locale: const Locale('en'),
      embedBuilders: const [],
    );
  }
}
