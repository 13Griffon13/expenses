
import 'dart:async';

import 'package:finances/model/purchase_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService{

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PurchaseRecordAdapter());
    Hive.registerAdapter(PurchaseTypesAdapter());
    await Hive.openBox('purchasesBox');
  }

  Iterable loadList(){
    return Hive.box('purchasesBox').values;
  }

  void saveRecord(PurchaseRecord record){
    Hive.box('purchasesBox').put(record.id, record);
  }

  void deleteRecord(PurchaseRecord record){
    Hive.box('purchasesBox').delete(record.id);
  }

  void dispose(){
    Hive.close();
  }
}
