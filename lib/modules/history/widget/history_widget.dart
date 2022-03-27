// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockcry/constant/colors.dart';

import '../../../custom_widgets/history_info_view.dart';

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
        backgroundColor: PRIMARY_COLOR,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: allData.map((doc) {
                    return HistoryInfoView(
                      date: doc.id,
                      data: doc,
                    );
                  }).toList(),
                ),
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
