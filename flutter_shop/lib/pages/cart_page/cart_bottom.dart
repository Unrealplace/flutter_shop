import 'package:flutter/material.dart';
import '../../config/index.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';
import '../../model/cart_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Provide<CartProvide>(
        builder: (context,child,scope){
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context),
            ],
          );
        },
      ),
    );
  }

  // 全选按钮
  Widget selectAllBtn(BuildContext context) {
    bool allCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: allCheck,
              activeColor: KColor.checkBoxSelectedColor,
              onChanged: (val){
                Provide.value<CartProvide>(context).changeAllCheckState(val);
              }
          ),
          Text('全选'),
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(BuildContext context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    String allPriceStr = allPrice.toStringAsFixed(2);
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '合计',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '￥${allPriceStr}',
                  style: TextStyle(
                    color: KColor.presentPriceTextColor,
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              )
            ],
          )
        ],
      ),

    );

  }

  // 结算按钮
  Widget goButton(BuildContext context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;

    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){

        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: KColor.primaryColor,
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}