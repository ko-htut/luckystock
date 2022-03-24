import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorResponseWidget extends StatefulWidget {
  final String errorMessage;
  const ErrorResponseWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  _ErrorResponseWidgetState createState() => _ErrorResponseWidgetState();
}

class _ErrorResponseWidgetState extends State<ErrorResponseWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset('assets/lottie/error.json',
                  height: 250, width: 250)),
          Text(
            widget.errorMessage,

            style: const TextStyle(fontSize: 13, color: Colors.red),
          )
        ],
      ),
    );
  }
}
