import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState>{

  HiveService hive;

  CategoriesBloc({initialState,  required this.hive}) : super(initialState){
   on<CategoriesAdded>((event, emmit){
      hive.addCategory(event.category);
      emit(CategoriesState(categories: _getCategoryList()));
   });
   on<CategoriesDeleted>((event, emmit){
      hive.deleteCategory(event.category);
      emit(CategoriesState(categories: _getCategoryList()));
   });
  }


  List<PurchaseCategory> _getCategoryList(){
    List<PurchaseCategory> result = [];
    hive.loadCategories().forEach((element) {
      result.add(element);
    });
    return result;
  }
}