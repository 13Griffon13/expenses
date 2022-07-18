import 'package:finances/model/purchase_category.dart';

class CategoriesState{

  Map<String,PurchaseCategory> categories;

  CategoriesState({required this.categories});

  PurchaseCategory getCategoryById(String id){
    return categories[id]??PurchaseCategory(id: '-', name: "Unidentified");
  }

  bool isCategoryExist(String id){
    return categories.containsKey(id);
  }
}