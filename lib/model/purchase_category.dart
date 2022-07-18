
class PurchaseCategory {
  String id;
  String name;

  PurchaseCategory({required this.id, required this.name});

  PurchaseCategory.fromMap(Map<String, dynamic> map):
      id = map['id'],
      name = map['name'];


  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }



  bool compareWith(PurchaseCategory category) {
    return category.id == id;
  }
}
