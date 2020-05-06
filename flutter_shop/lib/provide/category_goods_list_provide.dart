import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';


class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  addGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}