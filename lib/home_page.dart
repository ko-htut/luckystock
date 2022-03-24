import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> testList = [1, 2, 3, 4, 5, 6];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Wrap(
                spacing: 7.0,
                runSpacing: 7.0,
                children: testList.map((item) {
                  return NumberBoxView(
                    decoration: roundedDecoration(),
                  );
                }).toList(),
              ),
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
  RecordInfoView(
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
          TextWidget(text: "မှတ်တမ်း"),
          const SizedBox(
            height: 10.0,
          ),
          ListTileView(
            text: "၅ရက်စာ မှတ်တမ်း",
            decoration: innerDecoration,
          ),
          const SizedBox(
            height: 5.0,
          ),
          ListTileView(
            text: "3D ပေါက်စဥ်",
            decoration: innerDecoration,
          ),
        ],
      ),
    );
  }
}

class ListTileView extends StatelessWidget {
  final Decoration decoration;
  final String text;
  ListTileView({required this.decoration, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class StockInfoView extends StatelessWidget {
  final Decoration decoration;
  StockInfoView({required this.decoration});

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
              TextWidget(text: "30/10/2021"),
              TextWidget(text: "08:11:35 PM"),
            ],
          ),
          const Spacer(),
          TextWidget(
            text: "37",
            size: 56,
            color: const Color.fromRGBO(74, 135, 135, 1),
            isBold: true,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnWidget(
                startText: "SET",
                endText: "1,623.23",
              ),
              ColumnWidget(
                startText: "VALUE",
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
  final Decoration decoration;
  NumberBoxView({required this.decoration});
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
            text: "12.1 PM",
            size: 18,
          ),
          TextWidget(
            text: "50",
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
  ColumnWidget({required this.startText, required this.endText});
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
  TextWidget(
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
