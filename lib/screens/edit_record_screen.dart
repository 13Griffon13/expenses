import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:uuid/uuid.dart';

//todo need to revisit this
class EditRecordScreen extends StatefulWidget {
  final PurchaseRecord? record;

  const EditRecordScreen({Key? key, this.record}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditRecordScreenState(record: record);
  }
}

class _EditRecordScreenState extends State<EditRecordScreen> {
  TextEditingController sumController;
  TextEditingController descriptionController;
  DateTime selectedDate;
  String categoryId;
  String id;

  _EditRecordScreenState(
      {PurchaseRecord? record})
      : sumController =
            TextEditingController(text: record?.sum.toString() ?? '100.0'),
        descriptionController =
            TextEditingController(text: record?.description ?? ""),
        selectedDate = record?.date ?? DateTime.now(),
        id = record?.id ?? '!@#%^&',
        categoryId = record?.categoryId ?? '_';

  @override
  void initState() {
    super.initState();
    var state = BlocProvider.of<CategoriesBloc>(context).state;
    if (id == '!@#%^&') {
      id = const Uuid().v1();
      categoryId = state.categories.values.first.id;
    }
    if(!state.isCategoryExist(categoryId)){
      categoryId = state.categories.values.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        bloc: BlocProvider.of<CategoriesBloc>(context),
        builder: (BuildContext context, state) {
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
                          selectedDate = date;
                        },
                        onConfirm: (date) {
                          selectedDate = date;
                        },
                        currentTime: selectedDate,
                        locale: LocaleType.en,
                      );
                      setState(() {});
                    },
                    child: Text(
                      StringsUtility.dateToString(selectedDate),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: sumController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      maxLines: 1,
                    ),
                  ),
                  DropdownButton<String>(
                    items: state.categories.values.map((e) {
                      return DropdownMenuItem<String>(
                        child: Text(e.name),
                        value: e.id,
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        categoryId = newValue!;
                      });
                    },
                    value: categoryId,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Description(optional)',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ListOfRecordsBloc>(context)
                          .add(RecordEdited(
                        record: PurchaseRecord(
                          id: id,
                          sum: double.parse(sumController.text),
                          date: selectedDate,
                          categoryId: categoryId,
                          description: descriptionController.text,
                        ),
                      ));
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
