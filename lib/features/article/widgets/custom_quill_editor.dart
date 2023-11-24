// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CustomQuillEditor extends StatelessWidget {
  const CustomQuillEditor({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onTap,
    this.showCursor = true,
    required this.focusNode,
  
  });
  final QuillController controller;
  final String hintText;
  final VoidCallback onTap;
  final bool showCursor;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: controller,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en'),
        ),
      ),
      child: Column(
        children: [
         
          Expanded(
            child: QuillEditor(
              configurations: QuillEditorConfigurations(
                  scrollable: true,
                  autoFocus: false,
                  readOnly: false,
                  expands: false,
                  showCursor: showCursor,
                  placeholder: hintText,
                  padding: EdgeInsets.zero,
                  keyboardAppearance: Brightness.light,
                  embedBuilders: const [],
                  onTapDown: (tapdown, offset) {
                    onTap();
                    return false;
                  },
                  onTapUp: (tapup, offset) {
                    onTap();
                    return false;
                  }),
              focusNode: focusNode,
              scrollController: ScrollController(),
            ),
          )
        ],
      ),
    );
  }
}
