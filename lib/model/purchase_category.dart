import 'package:hive/hive.dart';

part 'purchase_category.g.dart';

@HiveType(typeId: 2)
class PurchaseCategory {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  PurchaseCategory({required this.id, required this.name});
}