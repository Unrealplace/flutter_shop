import 'package:flutter/material.dart';
import '../model/cart_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {

  String cartString = '[]';
  List<CartInfoModel> cartList = [];//商品列表对象
  double allPrice = 0; // 总价格
  int allGoodsCount = 0; //商品总数
  bool isAllCheck = true; //是否全选

  save(goodsId,goodsName,count,price,images) async {
    // 先获取本地存储的数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');//获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    // 强制转换
    List<Map> tempList = (temp as List).cast();

    var isHave = false;//用于判断购物车中是否存在此商品id
    int ival = 0;//用于循环的索引引用
    allPrice = 0;//
    allGoodsCount = 0;//商品总数量

    tempList.forEach((item){
      // 如果已经有这个商品了 数量增加
       if (item['goodsId'] == goodsId) {
         tempList[ival]['count'] = item['count'] + 1;
         cartList[ival].count++;
         isHave = true;
       }
       // 判断是否勾选
       if (item['isCheck']) {
         allPrice += (cartList[ival].price * cartList[ival].count);
         allGoodsCount += cartList[ival].count;
       }
       ival++;
    });

    // 如果不存在
    if (!isHave) {
      Map<String,dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck':true,
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
      allPrice += count * price;
      allGoodsCount += count;
    }

    // 保存数据到本地
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    cartList = [];
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item){
        if (item['isCheck']){
          allPrice += item['count'] * item['price'];
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  changeCheckState(CartInfoModel cartItem) async {
    // 先获取本地存储的数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');//获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    int tempIndex = 0;
    int changeIndex = -1;

    // 强制转换
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    if (changeIndex >= 0) {
      tempList[changeIndex] = cartItem.toJson();
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
    notifyListeners();
  }

  deleteOneGoods(String goodsId) async {
    // 先获取本地存储的数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');//获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    int tempIndex = 0;
    int deleteIndex = -1;

    // 强制转换
    List<Map> tempList = (temp as List).cast();

    tempList.forEach((item){
      if(item['goodsId'] == goodsId) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });

    if (deleteIndex >= 0) {
      tempList.removeAt(deleteIndex);
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);

    await getCartInfo();
    notifyListeners();
  }
}