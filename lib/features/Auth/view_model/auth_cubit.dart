import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/Auth/data/firebase_service.dart';

import 'package:news/features/Auth/view_model/states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthApiService authApiService;

  AuthCubit(this.authApiService) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regNameController = TextEditingController();
  final TextEditingController regPassController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void register() async {
    if (!registerFormKey.currentState!.validate()) return;

    emit(RegisterLoadingState());

    try {
      final user = await authApiService.register(
        name: regNameController.text.trim(),
        email: regEmailController.text.trim(),
        password: regPassController.text,
      );
      emit(RegisterSuccessState(user));
    } catch (error) {
      emit(RegisterErrorState(_handleAuthError(error)));
    }
  }

  void login() async {
    if (!loginFormKey.currentState!.validate()) return;

    emit(LoginLoadingState());

    try {
      final user = await authApiService.login(
        email: loginEmailController.text.trim(),
        password: loginPassController.text,
      );
      emit(LoginSuccessState(user));
    } catch (error) {
      emit(LoginErrorState(_handleAuthError(error)));
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This email address is already registered.';
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'invalid-email':
          return 'The email address is badly formatted.';
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return 'Invalid email or password.';
        case 'network-request-failed':
          return 'Please check your internet connection.';
        default:
          return error.message ?? 'Authentication failed.';
      }
    } else if (error is FirebaseException) {
      return error.message ?? 'Database connection error.';
    }
    return error.toString().replaceAll('Exception: ', '');
  }
Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
  emit(LogoutSuccessState());
}
  @override
  Future<void> close() {
    regEmailController.dispose();
    regNameController.dispose();
    regPassController.dispose();
    loginEmailController.dispose();
    loginPassController.dispose();
    return super.close();
  }
}