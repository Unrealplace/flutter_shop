import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/http_service.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {

  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) {
    var formData = {'goodId':id};
     request('getGoodDetail',formData: formData).then((val){
      var data = json.decode(val.toString());
      goodsInfo = DetailsModel.map(data);
      print(goodsInfo.toMap());
      notifyListeners();
    });
  }

}