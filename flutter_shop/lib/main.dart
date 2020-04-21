import 'package:flutter/material.dart';

import 'package:flutter_shop/config/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: KString.homeTitle,// flutter 女装商城
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: KColor.primaryColor
      ),
    );
  }
}
