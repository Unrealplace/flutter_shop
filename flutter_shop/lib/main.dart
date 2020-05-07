import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'provide/current_index_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/category_provide.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'package:flutter_shop/provide/cart_provide.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var categoryProvider = CategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();

  var providers = Providers();
  // .. 可以添加多个状态
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<CategoryProvide>.value(categoryProvider))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
  ;
  // ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态。
  runApp(
    ProviderNode(
      child: IndexPage(),
      providers: providers,
    )
  );
}

