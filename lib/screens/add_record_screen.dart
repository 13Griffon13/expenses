import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

class AddRecordScreen extends StatefulWidget {
  PurchaseRecord record;

  AddRecordScreen({PurchaseRecord? record})
      : record = record ??
            PurchaseRecord(
              id: const Uuid().v1(),
              sum: 100.0,
              date: DateTime.now(),
              type: PurchaseTypes.groceries,
            );

  @override
  State<StatefulWidget> createState() {
    return _AddRecordScreenSate();
  }
}

class _AddRecordScreenSate extends State<AddRecordScreen> {
  PurchaseTypes dropdownValue = PurchaseTypes.groceries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Record'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    widget.record.date = date;
                  },
                  onConfirm: (date) {
                    widget.record.date = date;
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
                setState(() {});
              },
              child: Text(
                StringsUtility.dateToString(widget.record.date),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(
                  text: widget.record.sum.toString(),
                ),
                keyboardType: TextInputType.numberWithOptions(),
                maxLines: 1,
                onChanged: (text) {
                  widget.record.sum = double.parse(text);
                },
                onSubmitted: (text) {
                  widget.record.sum = double.parse(text);
                },
              ),
            ),
            DropdownButton<PurchaseTypes>(
              items: PurchaseTypes.values.map((PurchaseTypes type) {
                return DropdownMenuItem<PurchaseTypes>(
                  value: type,
                  child: Text(type.name),
                );
              }).toList(),
              onChanged: (newValue) {
                widget.record.type = newValue!;
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              value: dropdownValue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(text: widget.record.description ?? ''),
                decoration: const InputDecoration(
                  hintText: 'Description(optional)',
                ),
                onChanged: (description) {
                  widget.record.description = description;

                },
                onSubmitted: (description) {
                  widget.record.description = description;
                  setState(() {});
                },
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<ListOfRecordsBloc>(context)
                    .add(RecordEdited(record: widget.record));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
