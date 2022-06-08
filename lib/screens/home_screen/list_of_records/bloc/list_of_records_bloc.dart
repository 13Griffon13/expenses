import 'package:finances/model/filter_settings.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/purchase_record.dart';
import 'list_of_records_state.dart';

class ListOfRecordsBloc extends Bloc<ListOfRecordsEvent, ListOfRecordsState> {
  ListOfRecordsBloc() : super(ListOfRecordsState()) {
    on<InitiateRecords>((event, emit) async {
      try {
        emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
        await hive.init();
        emit(
          ListOfRecordsState(
              records: _listLoader(), status: ListOfRecordsStatus.success),
        );
      } catch (e) {
        emit(ListOfRecordsState(status: ListOfRecordsStatus.error));
      }
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
      filterSettings = event.filterSettings;
      emit(ListOfRecordsState(
          records: _listLoader(), status: ListOfRecordsStatus.success));
    });
  }

  FilterSettings filterSettings = FilterSettings();
  HiveService hive = HiveService();

  List<PurchaseRecord> _listLoader() {
    List<PurchaseRecord> list = [];
    hive.loadList().forEach((element) {
      try {
        element as PurchaseRecord;
        if (element.date.isAfter(filterSettings.from) &&
            element.date.isBefore(filterSettings.to)) {
          if (filterSettings.type != null) {
            if (filterSettings.type == element.type) {
              list.add(element);
            }
          } else {
            list.add(element);
          }
        }
      } catch (e) {

      }
    });
    return list;
  }
}
