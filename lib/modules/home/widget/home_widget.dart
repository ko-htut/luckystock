// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockcry/modules/history/history_module.dart';
import 'package:stockcry/modules/history/history_route.dart';
import 'package:stockcry/utils/route_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../custom_widgets/column_widget.dart';
import '../../../custom_widgets/text_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

DocumentSnapshot? snapshot;

class _HomeWidgetState extends State<HomeWidget> {
  List<String> timeList = [
    "9:00AM",
    "12:00PM",
    "2:00PM",
    "4:00PM",
    "6:00PM",
    "9:00PM"
  ];

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final Stream<QuerySnapshot> daily =
      FirebaseFirestore.instance.collection("daily").snapshots();

  final Stream<QuerySnapshot> current =
      FirebaseFirestore.instance.collection("lucky2d").snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 110, 194, 113),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: current,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> shapShot) {
                    if (shapShot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (shapShot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    final DocumentSnapshot currentDoc = shapShot.data!.docs[0];
                    return StockInfoView(
                      date: currentDate,
                      data: currentDoc,
                      decoration: bottomRoundedDecoration(),
                    );
                  }),
              const SizedBox(
                height: 10.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: daily,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> shapShot) {
                  if (shapShot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (shapShot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  final data = shapShot.data!;
                  final allData = data.docs.map((doc) => doc).toList();

                  return Wrap(
                    spacing: 7.0,
                    runSpacing: 7.0,
                    children: timeList.map((item) {
                      String temp = "$currentDate ($item)";
                      var raw;
                      String number = "??";
                      allData.forEach((element) {
                        if (element.id == temp) {
                          raw = element.data();
                          number = raw["number"];
                          if (number == "" || number.isEmpty) {
                            number = "??";
                          }
                        }
                      });

                      return NumberBoxView(
                        decoration: roundedDecoration(),
                        number: number.toString(),
                        time: item,
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RecordInfoView(
                outerDecoration: topRoundedDecoration(),
                innerDecoration: roundedDecoration()),
          )
        ],
      )),
    );
  }

  BoxDecoration bottomRoundedDecoration() {
    return const BoxDecoration(
      color: Color.fromARGB(255, 110, 194, 113),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    );
  }

  BoxDecoration roundedDecoration() {
    return const BoxDecoration(
      color: Color.fromARGB(255, 173, 236, 165),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }

  BoxDecoration topRoundedDecoration() {
    return const BoxDecoration(
      color: Color.fromARGB(255, 129, 206, 119),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    );
  }
}

class RecordInfoView extends StatelessWidget {
  final Decoration outerDecoration;
  final Decoration innerDecoration;
  const RecordInfoView(
      {required this.outerDecoration, required this.innerDecoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 200,
      width: double.infinity,
      decoration: outerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(text: "မှတ်တမ်း"),
          const SizedBox(
            height: 10.0,
          ),
          ListTileView(
            text: "၅ရက်စာ မှတ်တမ်း",
            decoration: innerDecoration,
            onTap: () {
              RouteUtils.changeRoute<HistoryModule>(HistoryRoute.root);
            },
          ),
          const SizedBox(
            height: 5.0,
          ),
          ListTileView(
              text: "2D ပေါက်စဥ်",
              decoration: innerDecoration,
              onTap: () {
                RouteUtils.changeRoute<HistoryModule>(HistoryRoute.root);
              }),
        ],
      ),
    );
  }
}

class ListTileView extends StatelessWidget {
  final Decoration decoration;
  final String text;
  final Function() onTap;
  const ListTileView(
      {required this.decoration, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: decoration,
        child: ListTile(
          minLeadingWidth: 0.0,
          leading: const Icon(Icons.info),
          title: TextWidget(text: text),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 15.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class StockInfoView extends StatelessWidget {
  final Decoration decoration;
  final String date;
  final DocumentSnapshot? data;
  const StockInfoView(
      {required this.decoration, required this.date, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 200,
      width: double.infinity,
      decoration: decoration,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(text: date),
              const TextWidget(text: "12:PM"),
            ],
          ),
          const Spacer(),
          TextWidget(
            text: "${data?.get("number")}",
            size: 56,
            color: const Color.fromRGBO(50, 100, 137, 1),
            isBold: true,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnWidget(
                startText: "BUY",
                endText: "${data?.get("buy")}",
              ),
              ColumnWidget(
                startText: "SELL",
                endText: "${data?.get("sell")}",
              )
            ],
          )
        ],
      ),
    );
  }
}

class NumberBoxView extends StatelessWidget {
  final String time;
  final String number;
  final Decoration decoration;
  const NumberBoxView(
      {required this.time, required this.number, required this.decoration});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 85,
      width: 170,
      decoration: decoration,
      child: Column(
        children: [
          TextWidget(
            text: time,
            size: 18,
          ),
          TextWidget(
            text: number,
            isBold: true,
            size: 32,
            color: const Color.fromRGBO(50, 100, 137, 1),
          )
        ],
      ),
    );
  }
}
