import 'package:finances/model/filter_settings.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_of_records_state.dart';

class ListOfRecordsBloc extends Bloc<ListOfRecordsEvent, ListOfRecordsState> {

  FilterSettings filterSettings = FilterSettings();
  HiveService hive;

  ListOfRecordsBloc({required this.hive}) : super(ListOfRecordsState()) {
    on<InitiateRecords>((event, emit) async {
      filterSettings = _settingsFormat(filterSettings);
      emit(ListOfRecordsState(
          records: _listLoader(), status: ListOfRecordsStatus.success));
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



  List<PurchaseRecord> _listLoader() {
    List<PurchaseRecord> list = [];
    hive.loadList().forEach(
      (element) {
        try {
          element as PurchaseRecord;
          if (_dateFilter(element) && _categoryFilter(element)) {
            list.add(element);
          }
        } catch (e) {}
      },
    );
    return list;
  }

  bool _dateFilter(PurchaseRecord record){
    return record.date.isAfter(filterSettings.from) &&
        record.date.isBefore(filterSettings.to);
  }


  //todo find out why it wasn't work with list.contain()
  bool _categoryFilter(PurchaseRecord record) {
    if(filterSettings.categories == null){
      return true;
    }else{
      for (var element in filterSettings.categories!) {
        if(element.compareWith(record.category)){
          return true;
        }
      }
      return false;
    }
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
