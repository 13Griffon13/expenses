
import 'dart:async';

import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService{

  static const String purchaseBoxName = 'purchasesBox';
  static const String categoriesBoxName = 'categories';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PurchaseRecordAdapter());
    Hive.registerAdapter(PurchaseCategoryAdapter());
    await Hive.openBox(purchaseBoxName);
    await Hive.openBox(categoriesBoxName);
  }

  Iterable loadCategories(){
    return Hive.box(categoriesBoxName).values;
  }

  void addCategory(PurchaseCategory category){
    Hive.box(categoriesBoxName).put(category.id, category);
  }

  void deleteCategory(PurchaseCategory category){
    Hive.box(categoriesBoxName).delete(category.id);
  }

  Iterable loadList(){
    return Hive.box(purchaseBoxName).values;
  }

  void saveRecord(PurchaseRecord record){
    Hive.box(purchaseBoxName).put(record.id, record);
  }

  void deleteRecord(PurchaseRecord record){
    Hive.box(purchaseBoxName).delete(record.id);
  }

  void dispose(){
    Hive.close();
  }
}
