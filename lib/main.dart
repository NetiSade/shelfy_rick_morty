import 'package:flutter/material.dart';

import 'consts.dart';
import 'pages/character_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        CharacterPage.routeName: (_) => CharacterPage(),
      },
      home: HomePage(),
    );
  }
}
