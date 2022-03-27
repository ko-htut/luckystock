import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockcry/custom_widgets/text_widget.dart';

import '../../../constant/colors.dart';
import '../../../custom_widgets/history_info_view.dart';

class FiveDaysHistory extends StatefulWidget {
  FiveDaysHistory({Key? key}) : super(key: key);

  @override
  State<FiveDaysHistory> createState() => _FiveDaysHistoryState();
}

class _FiveDaysHistoryState extends State<FiveDaysHistory> {
  List<String> timeList = [
    "9:00AM",
    "12:00PM",
    "2:00PM",
    "4:00PM",
    "6:00PM",
    "9:00PM"
  ];
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
          final allDateTime = shapShot.data!.docs.map((doc) => doc.id).toList();
          final allDate = allDateTime
              .map((datetime) => datetime.split(" ").first)
              .toSet()
              .toList()
              .take(5);
          var str;

          if (shapShot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: allDate.map((date) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: const BoxDecoration(
                            color: SECONDARY_COLOR,
                            //color: Color.fromARGB(255, 21, 179, 55),
                          ),
                          child: TextWidget(
                            text: date,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: allData.map((element) {
                            if (date == element.id.split(" ").first) {
                              str = allData.indexOf(element);
                              return HistoryInfoView(
                                  date:
                                      allData.elementAt(str).id.split(" ").last,
                                  data: allData.elementAt(str));
                            }
                            return const SizedBox();
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
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
