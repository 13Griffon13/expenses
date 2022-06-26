import 'package:finances/model/filter_settings.dart';
import 'package:finances/model/purchase_record.dart';

enum ListOfRecordsStatus {loading, success, error }

class ListOfRecordsState {
  ListOfRecordsState(
      {this.status = ListOfRecordsStatus.success, List<PurchaseRecord>? records})
      : records = records ?? const [];


  List<PurchaseRecord>? records;
  ListOfRecordsStatus status;

  // ListOfRecordsState copyWith({List<PurchaseRecord>? records, ListOfRecordsState? status}){
  //   return ListOfRecordsState(
  //     records: records ?? this.records,
  //     status: status ?? this.status,
  //   );
  // }
}
