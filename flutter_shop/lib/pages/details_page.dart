import 'package:flutter/material.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import 'dart:convert';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';

class DetailsPage extends StatelessWidget {

  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.goodDetailsText),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
      body: FutureBuilder(
        builder: (context,snapshot){
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    DetailsPage(goodsId)
                  ],
                ),
                Positioned(
                  child: Text('底部组件'),
                  bottom: 0,
                  left: 0,
                )
              ],
            );
          } else {
            return Text('加载中。。。');
          }
        },
        future: _getGoodsInfo(context),
      ),
    );
  }


  Future _getGoodsInfo(BuildContext context) async {
   await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
  }
}
