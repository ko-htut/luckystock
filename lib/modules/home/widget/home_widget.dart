// ignore_for_file: use_key_in_widget_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockcry/modules/history/history_module.dart';
import 'package:stockcry/modules/history/history_route.dart';
import 'package:stockcry/utils/route_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constant/colors.dart';
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
      FirebaseFirestore.instance.collection("currency").snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        title: const Text("Lucky Daliy 2D"),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                    stream: current,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> shapShot) {
                      if (shapShot.hasError) {
                        return const Text("Something went wrong");
                      }
                      if (shapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final DocumentSnapshot currentDoc =
                          shapShot.data!.docs[0];
                      String dateTime = currentDoc.get("date_time");
                      var rawDT = dateTime.split(" ");
                      String date = rawDT[0];
                      if (shapShot.hasData) {
                        return StockInfoView(
                          date: date,
                          data: currentDoc,
                          decoration: bottomRoundedDecoration(),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                const SizedBox(
                  height: 10.0,
                ),
                StreamBuilder(
                  stream: daily,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> shapShot) {
                    if (shapShot.hasError) {
                      return const Text("something went wrong");
                    }
                    if (shapShot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final data = shapShot.data!;
                    final allData = data.docs.map((doc) => doc).toList();
                    if (shapShot.hasData) {
                      return Wrap(
                        spacing: 7.0,
                        runSpacing: 7.0,
                        children: timeList.map((item) {
                          String temp = "$currentDate ($item)";
                          var now = DateTime.now();
                          var raw;
                          String number = "??";
                          allData.forEach((element) {
                            if (element.id == temp) {
                              raw = element.data();
                              var datetime = raw["time"].toDate();
                              if (now.isAfter(datetime) == true) {
                                number = raw["number"];
                              } else {
                                number = "??";
                              }
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
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RecordInfoView(
          outerDecoration: topRoundedDecoration(),
          innerDecoration: roundedDecoration()),
    );
  }

  BoxDecoration bottomRoundedDecoration() {
    return const BoxDecoration(
      color: PRIMARY_COLOR,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(18.0),
        bottomRight: Radius.circular(18.0),
      ),
    );
  }

  BoxDecoration roundedDecoration() {
    return const BoxDecoration(
      color: ITEM_BACKGROUND_COLOR,
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }

  BoxDecoration topRoundedDecoration() {
    return const BoxDecoration(
      color: SECONDARY_COLOR,
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
          const TextWidget(
            text: "မှတ်တမ်း",
            color: Colors.white,
            isMyan: true,
          ),
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
          leading: const Icon(
            Icons.info,
            color: Colors.white,
          ),
          title: TextWidget(
            text: text,
            color: Colors.white,
            isMyan: true,
          ),
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
  StockInfoView({
    required this.decoration,
    required this.date,
    required this.data,
  });

  TimeOfDay initialTime = TimeOfDay.now();

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
              TextWidget(
                text: date,
                color: Colors.white,
              ),
              TextWidget(
                text: initialTime.format(context),
                // text: DateFormat.jm()
                //     .format(DateTime.parse(data!.get("date_time"))),
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                "${data?.get("number")}",
                textStyle: const TextStyle(
                    color: HOME_TEXT_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 56),
              ),
            ],
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
      height: 100,
      width: 170,
      decoration: decoration,
      child: Column(
        children: [
          TextWidget(
            text: time,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            height: 5,
          ),
          TextWidget(
            text: number,
            isBold: true,
            size: 32,
            color: HOME_TEXT_COLOR,
          )
        ],
      ),
    );
  }
}
