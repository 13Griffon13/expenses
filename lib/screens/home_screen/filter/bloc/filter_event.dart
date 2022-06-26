import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';

abstract class FilterEvent{

}

class DateChanged extends FilterEvent{
  DateTime dateTime;

  DateChanged({required this.dateTime});
}

class FromChanged extends DateChanged{
  FromChanged({required DateTime dateTime}) : super(dateTime: dateTime);
}

class ToChanged extends DateChanged{
  ToChanged({required DateTime dateTime}) : super(dateTime: dateTime);
}

class CategoryChanged extends FilterEvent{
  List<PurchaseCategory>? categories;

  CategoryChanged({required this.categories});
}

