import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool isBold;
  const TextWidget(
      {required this.text,
      this.size = 15,
      this.color = Colors.black,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : null,
      ),
    );
  }
}
