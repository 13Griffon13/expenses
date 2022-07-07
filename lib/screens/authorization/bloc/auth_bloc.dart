import 'package:finances/screens/authorization/bloc/auth_event.dart';
import 'package:finances/screens/authorization/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  AuthBloc(AuthState initialState) : super(initialState){
    on<AuthSignIn>((event, emit) async{
    });
    on<AuthSignUp>((event, emit){
      try{

      }catch(e){

      }
    });
  }

}