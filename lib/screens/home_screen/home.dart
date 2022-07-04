import 'package:finances/screens/home_screen/bottom_bar.dart';
import 'package:finances/screens/home_screen/list_of_records/list_of_records.dart';
import 'package:finances/screens/home_screen/popup_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: const [
          MainMenu(),
        ],
      ),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 36.0,
            ),
            child: ListOfRecords(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 12.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white,
                      Colors.white54,
                      Color.fromRGBO(255, 255, 255, 0)
                    ],
                    stops: [0.6, 0.75, 0.95],
                  ),
                ),
                child: const BottomBar(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
