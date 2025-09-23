import 'package:bloc_hive_caching_data/config/theme/app_theme.dart';
import 'package:bloc_hive_caching_data/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
