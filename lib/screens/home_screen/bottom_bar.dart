import 'package:finances/screens/edit_record_screen.dart';
import 'package:flutter/material.dart';


import 'filter/filter_widget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const FilterWidget(),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return const EditRecordScreen();
              }),
            );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
