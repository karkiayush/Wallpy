// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallpy/wallpaper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: WallpaperScreen(),
    );
  }
}
