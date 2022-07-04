import 'package:finances/model/purchase_category.dart';

class FilterSettings {
  DateTime from;
  DateTime to;
  List<PurchaseCategory>? categories;

  FilterSettings({DateTime? from, DateTime? to, this.categories})
      : from = from ?? DateTime.now().subtract(const Duration(days: 30)),
        to = to ?? DateTime.now();

  bool isCategorySelected(PurchaseCategory category){
    if(categories==null){
      return false;
    }
    for (var element in categories!) {
      if(element.id==category.id) {
        return true;
      }
    }
    return false;
  }

}
