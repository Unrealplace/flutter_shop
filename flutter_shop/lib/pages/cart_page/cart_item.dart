import 'package:flutter/material.dart';
import '../../config/index.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';
import '../../model/cart_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './cart_count.dart';

class CartItem extends StatelessWidget {

  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: KColor.defaultBorderColor
          )
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, item),
          _cartImage(item),
          _cartName(item),
          _cartPrice(context, item),
        ],
      ),
    );
  }

  Widget _cartCheckBt(BuildContext context,CartInfoModel item) {
    return Container(
      child: Checkbox(
          value: item.isCheck,
          activeColor: KColor.checkBoxSelectedColor,
          onChanged: (check){
            item.isCheck = check;
            Provide.value<CartProvide>(context).changeCheckState(item);
          }
      ),
    );
  }

  Widget _cartImage(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: KColor.defaultBorderColor
        )
      ),
      child: Image.network(item.images),
    );
  }

  Widget _cartName(CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  Widget _cartPrice(BuildContext context,CartInfoModel item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text(
              '￥${item.price}',
            style: TextStyle(
              color: KColor.presentPriceTextColor,
            ),
          ),
          Container(
            child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: KColor.deleteIconColor,
                size: 25,
              ),
            ),
          )
        ],
      ),

    );
  }
}