import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/screen/home_screen.dart';
import 'package:todo_list/config/theme.dart';
import 'package:todo_list/service/theme_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: HomeScreen(),
    );
  }
}
