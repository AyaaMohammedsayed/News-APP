import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/provider/settings.dart';
import 'package:provider/provider.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/features/home/view/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingServicesProvider(),
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingServicesProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            HomeScreen.routeName: (_) => HomeScreen(),
          },
          initialRoute: HomeScreen.routeName,
          
      
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: provider.currentMode,

     
        );
      },
    );
  }
}