import 'package:flutter/material.dart';
import 'package:phone_book/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Phone Book",
      theme: ThemeData(),
      home: MainMenu(),
    );
  }
}
