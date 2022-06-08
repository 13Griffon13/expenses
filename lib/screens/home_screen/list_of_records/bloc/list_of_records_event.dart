import 'package:finances/model/filter_settings.dart';
import 'package:finances/model/purchase_record.dart';

abstract class ListOfRecordsEvent{

}



class FilterChanged extends ListOfRecordsEvent{
 FilterSettings filterSettings;

 FilterChanged({required this.filterSettings});
}

class InitiateRecords extends ListOfRecordsEvent{

}

abstract class ListChangeEvent extends ListOfRecordsEvent{
  ListChangeEvent({required this.record});

  PurchaseRecord record;
}

class RecordDeleted extends ListChangeEvent{
  RecordDeleted({required PurchaseRecord record}) : super(record: record);

}

class RecordEdited extends ListChangeEvent{
  RecordEdited({required PurchaseRecord record}) : super(record: record);

}