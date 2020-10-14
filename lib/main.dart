import "package:flutter/material.dart";
import "formPage.dart";

void main() => runApp(DartsApp());

class DartsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: FormPage(),
    );
  }
}
