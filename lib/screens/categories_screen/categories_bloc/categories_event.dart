import 'package:finances/model/purchase_category.dart';

abstract class CategoriesEvent{

}

class InitiateCategories extends CategoriesEvent{

}

class UpdateCategories extends CategoriesEvent{
  Map<String,PurchaseCategory> categories;

  UpdateCategories({required this.categories});
}

class CategoriesAdded extends CategoriesEvent{

  PurchaseCategory category;

  CategoriesAdded({required this.category});
}

class CategoriesDeleted extends CategoriesEvent{

  PurchaseCategory category;

  CategoriesDeleted({required this.category});
}

class ResetCategories extends CategoriesEvent{

}