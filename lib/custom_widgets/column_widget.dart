import 'package:flutter/material.dart';

import 'text_widget.dart';

class ColumnWidget extends StatelessWidget {
  final String startText;
  final String endText;
  const ColumnWidget({required this.startText, required this.endText});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: startText),
        const SizedBox(
          height: 5.0,
        ),
        TextWidget(
          text: endText,
          color: const Color.fromRGBO(50, 100, 137, 1),
          isBold: true,
        ),
      ],
    );
  }
}