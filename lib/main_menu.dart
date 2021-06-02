import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_book/list_contact.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
      ),
      body: ListContact(),
    );
  }
}
