
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/core/firebase_service.dart';
import 'package:news/core/provider/user.dart';
import 'package:news/core/utils/util.dart';
import 'package:news/core/widgets/default_elevated_button.dart';
import 'package:news/core/widgets/default_text_form_field.dart';
import 'package:news/features/Auth/login_screen.dart';
import 'package:news/features/home/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context,listen: false);
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
                hintText: 'Name',
                controller: nameController,
                prefixIcon: 'name',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Invalid name';
                  return null;
                },
              ),
              SizedBox(height: 16),
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
              DefaultElevatedButton(
                onPressed: register,
                text: 'Create Account',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account ?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseService.register(
            email: emailController.text,
            password: passController.text,
            name: nameController.text,
          )
          .then((user) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            UIUtil.showSuccMessage("Register Successfully");
            userProvider.updateUser(user);
          })
          .catchError((error) {
            String? message;
            if (error is FirebaseAuthException) {
              message = error.message;
            }
            UIUtil.showSuccMessage(message!);
          });
      ;
    }
  }
}
