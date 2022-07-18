import 'package:finances/model/purchase_record.dart';

enum ListOfRecordsStatus {loading, success, error }

class ListOfRecordsState {
  ListOfRecordsState(
      {this.status = ListOfRecordsStatus.success, List<PurchaseRecord>? records})
      : records = records ?? const [];


  List<PurchaseRecord>? records;
  ListOfRecordsStatus status;


}
