import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddRecordScreen extends StatefulWidget {
  PurchaseRecord record;

  AddRecordScreen({Key? key, required this.record}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddRecordScreenState();
  }
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  @override
  Widget build(BuildContext context) {
    List<PurchaseCategory> categories =
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
      body: Padding(
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
                  currentTime: widget.record.date,
                  locale: LocaleType.en,
                );
                setState(() {});
              },
              child: Text(
                StringsUtility.dateToString(widget.record.date),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(
                  text: widget.record.sum.toString(),
                ),
                keyboardType: const TextInputType.numberWithOptions(),
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
                setState(() {});
              },
              value: widget.record.category,
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
