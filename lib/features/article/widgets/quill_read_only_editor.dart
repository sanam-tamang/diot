import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

///this editor will parse the quill json data into quilll string data by default,
///it has character limit of 160, and maxline is null
///max line null means show all the content out there of quill data
class QuillReadonlyEditor extends StatefulWidget {
  ///generally in the form of json encoded content of the quill data
  final String originalContent;

  ///[max line will help to determine the number length of the max line]
  ///if not maxlines not provided then it will show all the content
  final int? maxLines;

  const QuillReadonlyEditor(
      {super.key, required this.originalContent, this.maxLines});

  @override
  State<QuillReadonlyEditor> createState() => _QuillReadonlyEditorState();
}

class _QuillReadonlyEditorState extends State<QuillReadonlyEditor> {
  List _getQuillData(String quillData) {
    int totalLengthOfQuill = 0;
    int totalLengthLimit = 160;
    int totalNewLine = 0;
    int totalNewLineLimit = widget.maxLines!;
    final List decodedQuillData = jsonDecode(quillData);
    final decodedQuillModifiedList =
        decodedQuillData.take(widget.maxLines!).toList();

    final finalListQuillData =
        List.generate(decodedQuillModifiedList.length, (index) {
      String stringElement =
          decodedQuillModifiedList[index]["insert"].toString();
      Map? attribute = decodedQuillModifiedList[index]["attributes"];
      if (totalLengthOfQuill <= totalLengthLimit + 1 &&
          totalNewLine <= totalNewLineLimit + 1) {
        totalLengthOfQuill += stringElement.length;

        if (stringElement.length < totalLengthLimit) {
          totalNewLine += _countNewlines(stringElement);
          return {"insert": stringElement, "attributes": attribute};
        } else {
          totalNewLine += _countNewlines(stringElement);

          return {
            "insert": stringElement.substring(0, totalLengthLimit - 1),
            "attributes": attribute
          };
        }
      } else {
        return {"insert": ""};
      }
    }).toList();
    log(totalNewLine.toString());
    return finalListQuillData
      ..add({
        "insert": totalLengthOfQuill >= totalLengthLimit ||
                totalNewLine >= totalNewLineLimit ||
                decodedQuillModifiedList.length >= widget.maxLines!
            ? "...\n"
            : "\n"
      });
  }

  int _countNewlines(String text) {
    return text.split('\n').length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.maxLines != null
        ? _getQuillData(widget.originalContent)
        : jsonDecode(widget.originalContent);
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: QuillController(
        document: Document.fromJson(data),
        selection: TextSelection.fromPosition(const TextPosition(offset: 0)),
      ),
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en'),
        ),

        
      ), child:  QuillEditor.basic(
          configurations: const QuillEditorConfigurations(
             readOnly: true,
        scrollable: false,
        showCursor: false,
        enableInteractiveSelection: false,
        enableSelectionToolbar: false,
       
        autoFocus: false,
        scrollPhysics:  NeverScrollableScrollPhysics(),
        expands: false,
        padding: EdgeInsets.zero,
      
          )),
    );
  
    
  
  }
}
