import 'package:finances/model/purchase_category.dart';
import 'package:hive/hive.dart';

part 'purchase_record.g.dart';
//
// @HiveType(typeId: 2)
// enum PurchaseTypes {
//   @HiveField(0)
//   groceries,
//   @HiveField(1)
//   medicine,
//   @HiveField(2)
//   entertainments,
// }

@HiveType(typeId: 1)
class PurchaseRecord {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  double sum;
  @HiveField(3)
  PurchaseCategory category;
  @HiveField(4)
  String? description;

  PurchaseRecord(
      {required this.id,
      required this.sum,
      required this.date,
      required this.category,
      this.description});

  PurchaseRecord.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map['date'],
        sum = map['sum'],
        category = map['category'],
        description = map['description'];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'date': date,
      'sum': sum,
      'category': category,
      if (description != null) 'description': description!,
    };
  }
}
