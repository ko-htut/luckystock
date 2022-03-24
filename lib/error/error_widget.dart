import 'package:flutter/material.dart';
import 'package:stockcry/error/empty_widget.dart';

import 'error_response_widget.dart';

class ErrorWidget extends StatefulWidget {
  final String errorMessage;
  final bool isEmpty;
 const ErrorWidget({Key? key, required this.errorMessage, required this.isEmpty})
      : super(key: key);

  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
      if (widget.errorMessage != "null") {
      return ErrorResponseWidget(
        errorMessage: widget.errorMessage,
      );
    }else {
      return const EmptyWidget();
    }
    
    // return  Column(
    //         children: [
    //           Expanded(
    //             child: Text(
    //               "Empty",
    //               style: TextStyle(
    //                 fontFamily: 'pyidaungsu',
    //               ),
    //             ),
    //           ),
    //           widget.errorMessage != "null"
    //               ? Padding(
    //                   padding:
    //                       EdgeInsets.only(left: 20.0, right: 20, bottom: 70),
    //                   child: Text(
    //                     widget.errorMessage,
    //                     style: TextStyle(color: Colors.red),
    //                   ),
    //                 )
    //               : SizedBox()
    //         ],
    //       );
  }
}
