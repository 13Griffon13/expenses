import 'package:finances/model/purchase_category.dart';

abstract class CategoriesEvent{

}

class CategoriesAdded extends CategoriesEvent{

  PurchaseCategory category;

  CategoriesAdded({required this.category});
}

class CategoriesDeleted extends CategoriesEvent{

  PurchaseCategory category;

  CategoriesDeleted({required this.category});
}