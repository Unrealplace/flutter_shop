import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/http_service.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  bool isLeft = true;
  bool isRight = false;

  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetail', formData: formData).then((val) {
      var data = json.decode(val.toString());
      goodsInfo = DetailsModel.map(data);
      print(goodsInfo.toMap());
      notifyListeners();
    });
  }

  // 改变tabbar 状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
