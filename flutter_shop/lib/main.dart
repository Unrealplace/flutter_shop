import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'provide/current_index_provide.dart';
import 'package:provide/provide.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));

  runApp(
    ProviderNode(
      child: MyApp(),
      providers: providers,
    )
  );
}

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: RaisedButton(
          child: Text('click me'),
        ),
      ),
    );
  }
}
