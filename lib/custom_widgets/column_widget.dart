import 'package:flutter/material.dart';
import 'package:stockcry/constant/colors.dart';

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
        TextWidget(
          text: startText,
          color: const Color.fromARGB(255, 21, 179, 55),
          isBold: true,
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextWidget(
          text: endText,
          color: HOME_SUB_TEXT_COLOR,
          isBold: true,
        ),
      ],
    );
  }
}
