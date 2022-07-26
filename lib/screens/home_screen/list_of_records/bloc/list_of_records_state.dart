import 'package:finances/model/purchase_record.dart';

enum ListOfRecordsStatus { initial, loading, success, error }

class ListOfRecordsState {
  ListOfRecordsState(
      {this.status = ListOfRecordsStatus.success,
      List<PurchaseRecord>? records,
      this.error})
      : records = records ?? const [];

  ListOfRecordsState.initial()
      : status = ListOfRecordsStatus.initial,
        records = [];

  List<PurchaseRecord>? records;
  ListOfRecordsStatus status;
  String? error;
}
