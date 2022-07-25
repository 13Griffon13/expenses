import 'package:finances/model/purchase_category.dart';

enum CategoriesStateStatus{initial, success, error}

class CategoriesState{

  Map<String,PurchaseCategory> categories;
  CategoriesStateStatus status;

  CategoriesState({required this.categories, required this.status});

  CategoriesState.initial():
      categories = {},
      status = CategoriesStateStatus.initial;

  PurchaseCategory getCategoryById(String id){
    return categories[id]??PurchaseCategory(id: '-', name: "Unidentified");
  }

  bool isCategoryExist(String id){
    return categories.containsKey(id);
  }
}