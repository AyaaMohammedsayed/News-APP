import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/core/firebase_service.dart';
import 'package:news/core/provider/user.dart';
import 'package:news/core/utils/error_indicator.dart';
import 'package:news/core/utils/util.dart';
import 'package:news/core/widgets/default_elevated_button.dart';
import 'package:news/core/widgets/default_text_form_field.dart';
import 'package:news/features/Auth/register_screen.dart';
import 'package:news/features/home/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/news_logo_light.png',
                fit: BoxFit.fill,
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: 'Email',
                controller: emailController,
                prefixIcon: 'email',
                validator: (value) {
                  if (value == null || value.length < 5) return 'Invalid email';
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextFormField(
                hintText: 'Password',
                controller: passController,
                prefixIcon: 'lock',
                isPass: true,
                validator: (value) {
                  if (value == null || value.length < 8)
                    return 'Invalid password & Password Must be at least 8 character';
                  return null;
                },
              ),
              SizedBox(height: 24),
              DefaultElevatedButton(onPressed: login, text: 'Login'),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t Have Account ?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text,
            password: passController.text,
          )
          .then((user) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            UIUtil.showSuccMessage("Login Successfully");
            userProvider.updateUser(user);
          })
          .catchError((error) {
            String? message;
            if (error is FirebaseAuthException) {
              message = error.message;
            }
            ErrorIndicator();
          });
    }
  }
}
