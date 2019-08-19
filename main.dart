import 'package:flutter/material.dart';
import 'package:flutter_app/multiform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ønskeliste',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: MultiForm(),
    );
  }
}
