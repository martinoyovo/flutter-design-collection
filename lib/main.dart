import 'package:flutter/material.dart';
import 'package:flutter_logo_animation/airpod_animation.dart';
import 'package:flutter_logo_animation/redirect_animation.dart';
import 'package:flutter_logo_animation/scrolling_effect.dart';

import 'light_switch.dart';

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
      home: const AirpodAnimation()
    );
  }
}