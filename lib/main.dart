import 'package:finances/model/purchase_category.dart';
import 'package:finances/screens/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_bloc/categories_state.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_bloc.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_state.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/services/hive_service.dart';
import 'package:finances/util/basic_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/home_screen/home.dart';

void main() async {
  HiveService hive = HiveService();
  hive.init();
  runApp(MyApp(
    hive: hive,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.hive}) : super(key: key);

  final HiveService hive;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListOfRecordsBloc>(create: (context) {
          ListOfRecordsBloc bloc = ListOfRecordsBloc( hive:  hive);
          bloc.add(InitiateRecords());
          return bloc;
        }),
        BlocProvider<FilterBloc>(create: (BuildContext context) {
          return FilterBloc(FilterState());
        }),
        BlocProvider(create: (context) {
          return CategoriesBloc(_initCategoriesState());
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }

  CategoriesState _initCategoriesState(){
    List<PurchaseCategory> categories=[];
    hive.loadCategories().forEach((element) {
      categories.add(element);
    });
    if(categories.isEmpty){
      categories.add(BasicCategories.groceries);
      hive.addCategory(BasicCategories.groceries);
      categories.add(BasicCategories.medicine);
      hive.addCategory(BasicCategories.medicine);
      categories.add(BasicCategories.entertainments);
      hive.addCategory(BasicCategories.entertainments);
    }
    return CategoriesState(categories: categories);
  }
}
