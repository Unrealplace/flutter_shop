
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import '../../config/index.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../../provide/current_index_provide.dart';
import 'package:flutter_shop/provide/cart_provide.dart';

// 商品详细评论切换
class DetailsBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsID = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              // 带有角标的购物车状态
              Provide<CartProvide>(
               builder: (context,child,scope){
                 int goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                 return Positioned(
                   top: 0,
                   right: 10,
                   child: Container(
                     padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                     decoration: BoxDecoration(
                       color: KColor.primaryColor,
                       border: Border.all(
                         width: 2,
                         color: Colors.white,
                       ),
                       borderRadius: BorderRadius.circular(12.0),
                     ),
                     child: Text(
                       '${goodsCount}',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: ScreenUtil().setSp(22),
                       ),
                     ),
                   ),
                 );
               },
              ),
            ],
          ),
          InkWell(
            // 加入购物车
            onTap: () async {
              await Provide.value<CartProvide>(context).save(goodsID, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                KString.addToCartText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28)
                ),
              ),

            ),

          ),
          InkWell(
            // 马上购买
            onTap: () async {
              await Provide.value<CurrentIndexProvide>(context).changeIndex(2);
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: KColor.primaryColor,
              child: Text(
                KString.buyGoodsText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28)
                ),
              ),

            ),

          )
        ],
      ),
    );
  }
}