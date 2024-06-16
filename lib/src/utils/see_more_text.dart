// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int trimLength;
  final TextStyle? textStyle;
  final TextStyle? seeMoreTextStyle;

  const SeeMoreText({
    super.key,
    required this.text,
    this.trimLength = 100,
    this.textStyle,
    this.seeMoreTextStyle,
  });

  @override
  _SeeMoreTextState createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = isExpanded
        ? widget.text
        : (widget.text.length > widget.trimLength
            ? '${widget.text.substring(0, widget.trimLength)}...'
            : widget.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: widget.textStyle ?? const TextStyle(fontSize: 16),
        ),
        if (widget.text.length > widget.trimLength)
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'See Less' : 'See More',
              style: widget.seeMoreTextStyle ??
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
      ],
    );
  }
}
