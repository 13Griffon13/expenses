import 'package:finances/model/filter_settings.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_of_records_state.dart';

class ListOfRecordsBloc extends Bloc<ListOfRecordsEvent, ListOfRecordsState> {
  ListOfRecordsBloc({required this.hive}) : super(ListOfRecordsState()) {
    on<InitiateRecords>((event, emit) async {

    });
    on<RecordDeleted>((event, emit) {
      hive.deleteRecord(event.record);
      emit(ListOfRecordsState(
          records: _listLoader(), status: ListOfRecordsStatus.success));
    });
    on<RecordEdited>((event, emit) {
      hive.saveRecord(event.record);
      emit(ListOfRecordsState(
          records: _listLoader(), status: ListOfRecordsStatus.success));
    });
    on<FilterChanged>((event, emit) {
      filterSettings = _settingsFormat(event.filterSettings);
      emit(ListOfRecordsState(
          records: _listLoader(), status: ListOfRecordsStatus.success));
    });
  }

  FilterSettings filterSettings = FilterSettings();
  HiveService hive;

  List<PurchaseRecord> _listLoader() {
    List<PurchaseRecord> list = [];
    hive.loadList().forEach(
      (element) {
        try {
          element as PurchaseRecord;
          if (element.date.isAfter(filterSettings.from) &&
              element.date.isBefore(filterSettings.to)) {
            if (filterSettings.categories != null) {
              if (filterSettings.categories!.contains(element.category)) {
                list.add(element);
              }
            } else {
              list.add(element);
            }
          }
        } catch (e) {}
      },
    );
    return list;
  }


  //todo need to be revisited with addition of multi category filters
  FilterSettings _settingsFormat(FilterSettings settings) {
    return FilterSettings(
      to: DateTime(
        settings.to.year,
        settings.to.month,
        settings.to.day,
        23,
        59,
      ),
      from: DateTime(
        settings.from.year,
        settings.from.month,
        settings.from.day,
        0,
        0,
      ),
      categories: settings.categories,
    );
  }
}
