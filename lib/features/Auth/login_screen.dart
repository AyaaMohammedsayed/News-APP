import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/core/constants/app_images.dart';
import 'package:news/core/provider/user.dart';
import 'package:news/core/utils/util.dart';
import 'package:news/core/utils/validator.dart';
import 'package:news/core/widgets/default_elevated_button.dart';
import 'package:news/core/widgets/default_text_form_field.dart';

import 'package:news/features/Auth/data/firebase_service.dart';
import 'package:news/features/Auth/register_screen.dart';
import 'package:news/features/Auth/view_model/auth_cubit.dart';
import 'package:news/features/Auth/view_model/states.dart';
import 'package:news/features/home/view/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthApiService()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            context.read<UserProvider>().updateUser(state.user);
            UIUtil.showSuccMessage('Login Successfully');
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.routeName,
            );
          } else if (state is LoginErrorState) {
            UIUtil.showSuccMessage(state.message);
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);

          return Scaffold(
            backgroundColor: AppTheme.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: cubit.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.logo,
                          fit: BoxFit.fill,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        const SizedBox(height: 24),

                   
                        DefaultTextFormField(
                          hintText: 'Email',
                          controller: cubit.loginEmailController,
                          prefixIcon: 'email',
                          validator: Validator.validateEmail,
                        ),
                        const SizedBox(height: 16),

                
                        DefaultTextFormField(
                          hintText: 'Password',
                          controller: cubit.loginPassController,
                          prefixIcon: 'lock',
                          isPass: true,
                          validator: Validator.validatePassword,
                        ),
                        const SizedBox(height: 24),

                    
                        state is LoginLoadingState
                            ? const CircularProgressIndicator()
                            : DefaultElevatedButton(
                                onPressed: () => cubit.login(),
                                text: 'Login',
                              ),
                        const SizedBox(height: 24),

                     
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t Have Account ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppTheme.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RegisterScreen.routeName,
                                );
                              },
                              child: const Text('Create Account'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}