// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ShowLocalImageFile extends StatefulWidget {
  const ShowLocalImageFile({
    super.key,
    required this.imageFile,
    required this.deleteImage,
    this.aspectRadio = 1 / 0.7,
    this.fit = BoxFit.contain,
  });
  final Uint8List? imageFile;
  final VoidCallback deleteImage;
  final double aspectRadio;
  final BoxFit fit;
  @override
  State<ShowLocalImageFile> createState() => _ShowLocalImageFileState();
}

class _ShowLocalImageFileState extends State<ShowLocalImageFile> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return widget.imageFile == null
          ? const SizedBox.shrink()
          : Container(
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  AspectRatio(
                      aspectRatio: widget.aspectRadio,
                      child: Image.memory(fit: widget.fit, widget.imageFile!)),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                          onPressed: widget.deleteImage,
                          icon: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 28,
                            ),
                          )))
                ],
              ),
            );
    });
  }
}
