import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

class AddRecordScreen extends StatefulWidget {
  PurchaseRecord record;

  AddRecordScreen({required this.record});


  @override
  State<StatefulWidget> createState() {
    return _AddRecordScreenSate(record.category);
  }
}

class _AddRecordScreenSate extends State<AddRecordScreen> {

  PurchaseCategory dropdownValue;

  _AddRecordScreenSate(this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    List<PurchaseCategory>categories =
        BlocProvider.of<CategoriesBloc>(context).state.categories;
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
            DropdownButton<PurchaseCategory>(
              items: categories.map((PurchaseCategory category) {
                return DropdownMenuItem<PurchaseCategory>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (newValue) {
                widget.record.category = newValue!;
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              value: dropdownValue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(
                    text: widget.record.description ?? ''),
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
