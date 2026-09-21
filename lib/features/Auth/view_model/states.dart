import 'package:news/core/models/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}


class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final UserModel user;
  RegisterSuccessState(this.user);
}

class RegisterErrorState extends AuthState {
  final String message;
  RegisterErrorState(this.message);
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserModel user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState(this.message);
}
class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {

  LogoutSuccessState();
}

class LogoutErrorState extends AuthState {
  final String message;
  LogoutErrorState(this.message);
}