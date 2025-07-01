import 'package:flutter/material.dart';

import 'core/dependency_injection/dependency_injector.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qalla App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffFBFBFB)),
        scaffoldBackgroundColor: Color(0xffFBFBFB),
      ),
      home: HomeScreen(),
    );
  }
}
