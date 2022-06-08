import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/add_record_screen.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfRecordsElement extends StatefulWidget {
  final PurchaseRecord record;

  const ListOfRecordsElement({Key? key, required this.record})
      : super(key: key);

  @override
  State<ListOfRecordsElement> createState() => _ListOfRecordsElementState();
}

class _ListOfRecordsElementState extends State<ListOfRecordsElement> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          height: 50.0,
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 60),
                      child: Text(StringsUtility.dateToString(widget.record.date)),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    left: 80.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 130),
                      child: Text(widget.record.type.name),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    left: 10.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(widget.record.description ?? ''),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    right: 10.0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: Text(widget.record.sum.toString()),
                    ),
                  ),
                ],
              ),
              if (showActions)
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          showActions = !showActions;
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showActions = !showActions;
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AddRecordScreen(record: widget.record);
                          }));
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          context
                              .read<ListOfRecordsBloc>()
                              .add(RecordDeleted(record: widget.record));
                          setState(() {
                            showActions = !showActions;
                          });
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      onLongPress: () {
        showActions = !showActions;
        setState(() {});
      },
    );
  }

}
