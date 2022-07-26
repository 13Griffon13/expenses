import 'dart:async';

import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/services/firebase_services.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  FirebaseServices firebaseServices;
  StreamSubscription? collectionSubscription;

  CategoriesBloc({initialState, required this.firebaseServices})
      : super(initialState) {
    on<InitiateCategories>((event, emit) {
      collectionSubscription =
          firebaseServices.categoriesStream().listen((event) {
        add(UpdateCategories(categories: _documentsToObjects(event)));
      });
    });
    on<UpdateCategories>((event, emit) {
      if (event.categories.isEmpty) {
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
            categories: event.categories,
            status: CategoriesStateStatus.success));
      }
    });
    on<CategoriesAdded>((event, emmit) async {
      await firebaseServices.saveCategory(event.category);
    });
    on<CategoriesDeleted>((event, emmit) async {
      await firebaseServices.deleteCategory(event.category);
    });
    on<ResetCategories>((event, emit) {
      collectionSubscription!.cancel();
      emit(CategoriesState.initial());
    });
  }

  Map<String, PurchaseCategory> _documentsToObjects(List<Document> docs) {
    Map<String, PurchaseCategory> result = {};
    for (var element in docs) {
      result[element['id']] = PurchaseCategory.fromMap(element.map);
    }
    return result;
  }
}
