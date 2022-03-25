// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockcry/modules/history/history_module.dart';
import 'package:stockcry/modules/history/history_route.dart';
import 'package:stockcry/utils/route_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(246, 191, 135, 1),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              StockInfoView(
                decoration: bottomRoundedDecoration(),
              ),
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
                    children: timeList
                        .asMap()
                        .map((i, item) {
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

                          return MapEntry(
                              i,
                              NumberBoxView(
                                decoration: roundedDecoration(),
                                number: number.toString(),
                                time: item,
                              ));
                        })
                        .values
                        .toList(),
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
      color: Color.fromRGBO(246, 191, 135, 1),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
    );
  }

  BoxDecoration roundedDecoration() {
    return const BoxDecoration(
      color: Color.fromRGBO(246, 216, 187, 1),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }

  BoxDecoration topRoundedDecoration() {
    return const BoxDecoration(
      color: Color.fromRGBO(236, 208, 177, 1),
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
  const StockInfoView({required this.decoration});

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
            children: const [
              TextWidget(text: "30/10/2021"),
              TextWidget(text: "08:11:35 PM"),
            ],
          ),
          const Spacer(),
          const TextWidget(
            text: "37",
            size: 56,
            color: Color.fromRGBO(74, 135, 135, 1),
            isBold: true,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ColumnWidget(
                startText: "BUY",
                endText: "1,623.23",
              ),
              ColumnWidget(
                startText: "SELL",
                endText: "66,749.23",
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
            color: const Color.fromRGBO(74, 135, 135, 1),
          )
        ],
      ),
    );
  }
}

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
        TextWidget(
          text: endText,
          color: const Color.fromRGBO(74, 135, 135, 1),
          isBold: true,
        ),
      ],
    );
  }
}

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
