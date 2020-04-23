import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/index_page.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  // .. 可以添加多个状态
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
  ;
  // ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态。
  runApp(
    ProviderNode(
      child: IndexPage(),
      providers: providers,
    )
  );
}

