import 'package:flutter/material.dart';
import 'package:rental_ps/Screen/Splash_Screen.dart';
import 'package:rental_ps/Screen/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SplashScreen(),
      routes: {'/news-screen': (context) => const NewsScreen()},
    );
  }
}
