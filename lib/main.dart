import 'package:finances/screens/authorization/bloc/auth_bloc.dart';
import 'package:finances/screens/authorization/bloc/auth_state.dart';
import 'package:finances/screens/authorization/sign_in_screen.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_bloc.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_event.dart';
import 'package:finances/screens/categories_screen/categories_bloc/categories_state.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_bloc.dart';
import 'package:finances/screens/home_screen/filter/bloc/filter_state.dart';
import 'package:finances/screens/home_screen/home.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_bloc.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_event.dart';
import 'package:finances/screens/home_screen/list_of_records/bloc/list_of_records_state.dart';
import 'package:finances/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  FirebaseServices services = FirebaseServices();
  await services.init();
  runApp(MyApp(
    firebaseServices: services,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.firebaseServices}) : super(key: key);

  final FirebaseServices firebaseServices;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListOfRecordsBloc>(create: (context) {
          return ListOfRecordsBloc(
            initialState: ListOfRecordsState.initial(),
            firebaseServices: firebaseServices,
          );
        }),
        BlocProvider<FilterBloc>(create: (BuildContext context) {
          FilterBloc bloc = FilterBloc(FilterState.initial());
          bloc.stream.listen((event) {
            if (event.status == FilterStateStatus.success) {
              BlocProvider.of<ListOfRecordsBloc>(context)
                  .add(FilterChanged(filterSettings: event.settings));
            }
          });
          return bloc;
        }),
        BlocProvider<AuthBloc>(create: (context) {
          return AuthBloc(
            AuthState(status: AuthStatus.signedOut),
            firebaseServices: firebaseServices,
          );
        }),
        BlocProvider<CategoriesBloc>(create: (context) {
          CategoriesBloc bloc = CategoriesBloc(
            initialState: CategoriesState.initial(),
            firebaseServices: firebaseServices,
          );
          bloc.stream.listen((event) {
            BlocProvider.of<ListOfRecordsBloc>(context)
                .add(CategoriesChanged());
          });
          return bloc;
        }),
      ],
      child: MaterialApp(
        title: 'Expenses',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Builder(builder: (context) {
          return SafeArea(
            child: BlocBuilder<AuthBloc, AuthState>(
                bloc: BlocProvider.of<AuthBloc>(context),
                builder: (context, state) {
                  if (state.status == AuthStatus.signedIn) {
                    BlocProvider.of<ListOfRecordsBloc>(context)
                        .add(InitialListOfRecords());
                    BlocProvider.of<CategoriesBloc>(context)
                        .add(InitiateCategories());
                    return const HomePage();
                  } else {
                    return SignInScreen();
                  }
                }),
          );
        }),
      ),
    );
  }
}
