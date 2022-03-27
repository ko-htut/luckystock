import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import 'text_widget.dart';

class HistoryInfoView extends StatelessWidget {
  String date;
  DocumentSnapshot? data;
  HistoryInfoView({Key? key, required this.date, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     var now = DateTime.now();
    return Card(
      elevation: 0.3,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 3.0,
              ),
              TextWidget(
                text: "Number : ${data!.get("number")}",
                // text: "Number : ${now.isAfter(data!.get("time").toDate())}",
                color: HISTORY_TEXT_COLOR,
                isBold: true,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Buy : ${data!.get("buy")}",
                    color: HISTORY_SUB_TEXT_COLOR,
                    isBold: true,
                    size: 14,
                  ),
                  TextWidget(
                    text: "Sell : ${data!.get("sell")}",
                    color: HISTORY_SUB_TEXT_COLOR,
                    isBold: true,
                    size: 14,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextWidget(
                text: date,
                size: 14,
              ),
              const SizedBox(
                height: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}