import 'package:finances/screens/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent,CategoriesState>{
  CategoriesBloc(initialState) : super(initialState);

}