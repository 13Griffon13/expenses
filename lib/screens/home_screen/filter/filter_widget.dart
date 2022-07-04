import 'package:finances/screens/home_screen/filter/bloc/filter_bloc.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_event.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_state.dart';
import 'package:finances/screens/home_screen/filter/category_selection_dialogue.dart';
import 'package:finances/util/strings_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const CategorySelectionDialogue();
                      });
                },
                icon: Icon(
                  state.settings.categories == null
                      ? Icons.filter_alt_outlined
                      : Icons.filter_alt_sharp,
                ),
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (date) {},
                    onConfirm: (date) {
                      BlocProvider.of<FilterBloc>(context)
                          .add(FromChanged(dateTime: date));
                    },
                    currentTime: state.settings.from,
                    locale: LocaleType.en,
                  );
                },
                child: Text(StringsUtility.dateToString(state.settings.from)),
              ),
              TextButton(
                onPressed: () async {
                  await DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (date) {},
                    onConfirm: (date) {
                      BlocProvider.of<FilterBloc>(context)
                          .add(ToChanged(dateTime: date));
                    },
                    currentTime: state.settings.to,
                    locale: LocaleType.en,
                  );
                },
                child: Text(StringsUtility.dateToString(state.settings.to)),
              ),
            ],
          ),
        );
      },
    );
  }


}
