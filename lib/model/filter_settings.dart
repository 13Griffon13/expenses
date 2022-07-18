import 'package:finances/model/purchase_category.dart';

class FilterSettings {
  DateTime from;
  DateTime to;
  List<PurchaseCategory>? categories;

  FilterSettings({required DateTime from, required DateTime to, this.categories})
      : from = DateTime(from.year, from.month, from.day),
        to = DateTime(to.year, to.month, to.day, 23, 59, 59);



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
