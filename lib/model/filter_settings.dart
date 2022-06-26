import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';

class FilterSettings {
  DateTime from;
  DateTime to;
  List<PurchaseCategory>? categories;

  FilterSettings({DateTime? from, DateTime? to, this.categories})
      : from = from ?? DateTime.now().subtract(const Duration(days: 30)),
        to = to ?? DateTime.now();

}
