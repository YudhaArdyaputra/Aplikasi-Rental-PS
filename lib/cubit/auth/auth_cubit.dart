import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken) {
    emit(AuthState(isLoggedIn: true, accessToken: accessToken));
  }

  void logout() {
    emit(const AuthState(isLoggedIn: false, accessToken: ""));
  }
}