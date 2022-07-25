import 'package:finances/model/filter_settings.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/services/firebase_services.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_of_records_state.dart';

class ListOfRecordsBloc extends Bloc<ListOfRecordsEvent, ListOfRecordsState> {
  FilterSettings filterSettings = FilterSettings(
    from: DateTime.now().subtract(const Duration(days: 30)),
    to: DateTime.now(),
  );
  FirebaseServices firebaseServices;

  //variable docName will might be needed for optimization update, in witch
  //records will be saved not in 1 documents but to multiple documents
  // depending on date
  static const String docName = "records";

  ListOfRecordsBloc({required this.firebaseServices})
      : super(ListOfRecordsState.initial()) {
    firebaseServices.recordsStream(docName).listen((event) {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
      _exceptionCheck(() async {
        emit(ListOfRecordsState(
            records: _listLoader(event), status: ListOfRecordsStatus.success));
      });
    });
    on<InitialListOfRecords>((event, emit) async {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
    });
    on<CategoriesChanged>((event,emit){
      emit(ListOfRecordsState(
        status: ListOfRecordsStatus.success,
        records: state.records,
      ));
    });
    on<RecordDeleted>((event, emit) {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
      _exceptionCheck(() async {
        await firebaseServices.deleteRecord(event.record, docName);
      });
    });
    on<RecordAdded>((event, emit) async {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
      _exceptionCheck(() async {
        await firebaseServices.saveRecord(event.record, docName);
      });
    });
    on<RecordEdited>((event, emit) async {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
      _exceptionCheck(() async {
        await firebaseServices.editRecord(event.record, docName);
      });
    });
    on<FilterChanged>((event, emit) async{
      emit(ListOfRecordsState(status: ListOfRecordsStatus.loading));
      filterSettings = event.filterSettings;
      await firebaseServices
          .getRecords(filterSettings,docName)
          .then((value) => emit(ListOfRecordsState(
          status: ListOfRecordsStatus.success,
          records: _listLoader(value))));
    });
  }

  List<PurchaseRecord> _listLoader(List<Document> documents) {
    List<PurchaseRecord> list = [];
    for (var element in documents) {
      try {
        var record = PurchaseRecord.fromMap(element.map);
        if (_dateFilter(record) && _categoryFilter(record)) {
          list.add(record);
        }
      } catch (e) {
        emit(
            ListOfRecordsState(status: ListOfRecordsStatus.error, records: []));
      }
    }
    return list;
  }

  _exceptionCheck(VoidCallback callback) {
    try {
      callback();
    } catch (exception) {
      emit(ListOfRecordsState(status: ListOfRecordsStatus.error, records: []));
    }
  }

  bool _dateFilter(PurchaseRecord record) {
    return record.date.isAfter(filterSettings.from) &&
        record.date.isBefore(filterSettings.to);
  }

  //todo find out why it wasn't work with list.contain()
  bool _categoryFilter(PurchaseRecord record) {
    if (filterSettings.categories == null) {
      return true;
    } else {
      for (var element in filterSettings.categories!) {
        if (element.id == record.categoryId) {
          return true;
        }
      }
      return false;
    }
  }
}
