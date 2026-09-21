import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/core/provider/settings.dart';
import 'package:news/core/provider/user.dart';
import 'package:news/features/Auth/data/firebase_service.dart';
import 'package:news/features/Auth/view/login_screen.dart';
import 'package:news/features/Auth/view/register_screen.dart';
import 'package:news/features/Auth/view_model/auth_cubit.dart';
import 'package:news/features/home/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingServicesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(AuthApiService()),
        ),
      ],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingServicesProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          routes: {
            RegisterScreen.routeName: (_) => const RegisterScreen(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            HomeScreen.routeName: (_) =>  HomeScreen(),
          },

          initialRoute: RegisterScreen.routeName,

          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: provider.currentMode,
        );
      },
    );
  }
}