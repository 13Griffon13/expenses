import 'package:finances/model/purchase_record.dart';

class FilterSettings {
  DateTime from;
  DateTime to;
  PurchaseTypes? type;

  FilterSettings({DateTime? from, DateTime? to, this.type})
      : from = from ?? DateTime.now().subtract(const Duration(days: 30)),
        to = to ?? DateTime.now();

}
