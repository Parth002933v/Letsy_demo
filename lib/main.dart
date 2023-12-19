import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letsy_demo/features/application/view/application.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Letsy',
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: Colors.black,
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.black),
        ),
        home: Application(),
      ),
    );
  }
}
