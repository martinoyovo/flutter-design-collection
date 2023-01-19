import 'package:flutter/material.dart';
import 'package:flutter_logo_animation/flutterlogo/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Transform.scale(
        scale: 0.8,
        child: const LogoHome()
      )
    );
  }
}