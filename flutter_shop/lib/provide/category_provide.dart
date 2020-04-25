import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class CategoryProvide with ChangeNotifier {
  List <SecondCategoryVO> categoryGoodList = [];

  int secondCategoryIndex = 0; //二级分类索引
  int firstCategoryIndex = 0; //一级分类索引
  String firstCategoryId = '1'; //二级ID
  String secondCategoryId = '1'; //一级ID
  int page = 1; //列表页数
  String noMoreText = '';//显示更多
  bool isNewCategory = true;//

  // 首页点击类别时更改类别
  changeFirstCategory(String id, int index) {
    firstCategoryId = id;
    firstCategoryIndex = index;
    secondCategoryId = '';
    notifyListeners();
  }

  //获取二级分类数据
  getSecondCategory(List<SecondCategoryVO>list,String id) {
    isNewCategory = true;
    firstCategoryId = id;
    secondCategoryIndex = 0;
    page = 1;
    secondCategoryId = '';
    noMoreText = '';
    SecondCategoryVO all = SecondCategoryVO('00','xx','全部',null);
    categoryGoodList = [all];
    categoryGoodList.addAll(list);
    notifyListeners();
  }

  // 改变二类索引
  changeSecondIndex(int index,String id) {
    isNewCategory = true;
    secondCategoryIndex = index;
    secondCategoryId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage(){
    page++;
  }

  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }


}