// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frivia_app/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Frivia",
      home: StartPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black45,
          primarySwatch: Colors.red, fontFamily: 'ArchitectsDaughter'),
    );
  }


}
