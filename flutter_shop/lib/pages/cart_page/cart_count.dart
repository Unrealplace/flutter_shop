import 'package:flutter/material.dart';
import '../../config/index.dart';
import 'package:provide/provide.dart';
import '../../provide/cart_provide.dart';
import '../../model/cart_info_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {

  final CartInfoModel item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: ScreenUtil().setWidth(45 + 45 + 84),
      margin: EdgeInsets.only(top: 5.0,left: 5.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: KColor.defaultBorderColor,
          )
      ),
      child: Row(
          children: <Widget>[
            _reduceBtn(context),
            _countArea(),
            _addBtn(context),
          ],
      ),
    );
  }

  Widget _reduceBtn(BuildContext context) {

    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(this.item, false);
      },

      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : KColor.defaultBorderColor,
          border: Border(
            right: BorderSide(
              width: 1,
              color: KColor.defaultBorderColor,
            )
          )
        ),
        child: item.count > 1 ? Text('-') : Text(''),
      ),
    );
  }

  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(this.item, true);
      },

      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white ,
            border: Border(
                right: BorderSide(
                  width: 1,
                  color: KColor.defaultBorderColor,
                )
            )
        ),
        child: Text('+'),
      ),
    );

  }

  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: KColor.defaultBorderColor
        )
      ),
      child: Text(
        '${item.count}'
      ),
    );
  }

}