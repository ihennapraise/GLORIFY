import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const GlorifyApp());
}

class GlorifyApp extends StatelessWidget {
  const GlorifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glorify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}