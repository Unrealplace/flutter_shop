import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:flutter_shop/provide/detail_info_provide.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';
import './details_page/details_top_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';

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
        future: _getGoodsInfo(context),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    DetailsTopArea(),
                    DetailsExpain(),
                    DetailsTabBar(),
                    DetailsWeb(),
                  ],
                ),
                Positioned(
                  child: DetailsBottom(),
                  bottom: 0,
                  left: 0,
                )
              ],
            );
          } else {
            return Text('加载中。。。');
          }
        },
      ),
    );
  }


  Future _getGoodsInfo(BuildContext context) async {
   await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
   return '完成';
  }
}
