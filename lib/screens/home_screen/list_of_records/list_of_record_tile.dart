import 'package:finances/global_widgets/interactive_list_item.dart';
import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/edit_record_screen.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfRecordsElement extends StatefulWidget {
  final PurchaseRecord record;
  final PurchaseCategory category;

  const ListOfRecordsElement(
      {Key? key, required this.record, required this.category})
      : super(key: key);

  @override
  State<ListOfRecordsElement> createState() => _ListOfRecordsElementState();
}

class _ListOfRecordsElementState extends State<ListOfRecordsElement> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    return InteractiveListItem(
      height: 50.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade400,
              Colors.blueGrey.shade200,
              Colors.blueGrey.shade100,
              Colors.white
            ],
            stops: const [0.0, 0.5, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10.0,
              left: 14.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 60),
                child: _formattedText(
                    StringsUtility.dateToString(widget.record.date)),
              ),
            ),
            Positioned(
              top: 10.0,
              left: 80.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: _formattedText(widget.category.name),
              ),
            ),
            Positioned(
              top: 30.0,
              left: 14.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: _formattedText(widget.record.description ?? ''),
              ),
            ),
            Positioned(
              top: 30.0,
              right: 10.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: _formattedText(widget.record.sum.toString()),
              ),
            ),
          ],
        ),
      ),
      onDelete: () {
        context
            .read<ListOfRecordsBloc>()
            .add(RecordDeleted(record: widget.record));
        setState(() {
          showActions = !showActions;
        });
      },
      onEdit: () {
        showActions = !showActions;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EditRecordScreen(record: widget.record);
        }));
        setState(() {});
      },
    );
  }

  Widget _formattedText(String string) {
    return Text(
      string,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
