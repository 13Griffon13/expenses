import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/services/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  FirebaseServices firebaseServices;

  CategoriesBloc({initialState, required this.firebaseServices})
      : super(initialState) {
    firebaseServices.categoriesStream().listen((event) {
      Map<String, PurchaseCategory> result = {};
      for (var element in event) {
        result[element['id']] = PurchaseCategory.fromMap(element.map);
      }
      if (result.isEmpty) {
        add(
          CategoriesAdded(
            category: PurchaseCategory(
              id: const Uuid().v1(),
              name: "General",
            ),
          ),
        );
      } else {
        emit(CategoriesState(
            categories: result, status: CategoriesStateStatus.success));
      }
    });
    on<CategoriesAdded>((event, emmit) async {
      await firebaseServices.saveCategory(event.category);
    });
    on<CategoriesDeleted>((event, emmit) async {
      await firebaseServices.deleteCategory(event.category);
    });
  }
}
