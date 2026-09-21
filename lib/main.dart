import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/features/home/view/screens/home_screen.dart';

void main() {
  runApp(NewsApp());
}
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName:(_)=>HomeScreen()
        },
        initialRoute: HomeScreen.routeName,
        theme: AppTheme.light,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.dark,
      ),
    );
  }
}