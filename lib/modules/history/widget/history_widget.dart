// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockcry/custom_widgets/text_widget.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final Stream<QuerySnapshot> history =
      FirebaseFirestore.instance.collection("daily").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: const Color.fromARGB(255, 110, 194, 113),
      ),
      body: StreamBuilder(
        stream: history,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> shapShot) {
          if (shapShot.hasError) {
            return const Text("something went wrong");
          }
          if (shapShot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final allData = shapShot.data!.docs.map((doc) => doc).toList();
          if (shapShot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: allData.map((doc) {
                  return HistoryInfoView(
                    date: doc.id,
                    data: doc,
                  );
                }).toList(),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class HistoryInfoView extends StatelessWidget {
  String date;
  DocumentSnapshot? data;
  HistoryInfoView({Key? key, required this.date, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                color: const Color.fromRGBO(68, 148, 93, 1),
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
                    color: const Color.fromRGBO(50, 100, 137, 1),
                    isBold: true,
                    size: 14,
                  ),
                  TextWidget(
                    text: "Sell : ${data!.get("sell")}",
                    color: const Color.fromRGBO(50, 100, 137, 1),
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
