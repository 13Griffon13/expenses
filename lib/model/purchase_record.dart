
class PurchaseRecord {
  String id;
  DateTime date;
  double sum;
  String categoryId;
  String? description;

  PurchaseRecord(
      {required this.id,
      required this.sum,
      required this.date,
      required this.categoryId,
      this.description});

  PurchaseRecord.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        date = map['date'],
        sum = map['sum'],
        categoryId = map['categoryId'],
        description = map['description']??'';

  Map<String, Object> toFirebaseMap() {
    return {
      'id': id,
      'date': date,
      'sum': sum,
      'categoryId': categoryId,
      if (description != null) 'description': description!,
    };
  }
}
