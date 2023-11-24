import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomReadMore extends StatelessWidget {
  const CustomReadMore(this.text, {super.key, this.trimLines = 2, this.style});
  final String text;
  final int trimLines;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      style: style,
      colorClickableText: Colors.black54,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Show more',
      trimExpandedText: ' ...Show less',
      lessStyle: const TextStyle(
        fontSize: 16,
      ),
      moreStyle: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
