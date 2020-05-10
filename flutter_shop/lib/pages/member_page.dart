import 'package:flutter/material.dart';
import '../config/index.dart';
import '../provide/cart_provide.dart';
import 'package:provide/provide.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.memberTitle),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  Widget _topHeader(){
     return Container(
       width: ScreenUtil().setWidth(750),
       padding: EdgeInsets.all(20),
       color: KColor.primaryColor,
       child: Column(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(top: 30),
             child: ClipOval(
               child: SizedBox(
                 width: 120,
                 height: 120,
                 child: Image.asset('assets/girl.png',fit: BoxFit.cover,),
               ),
             ),
           ),
           Container(
             margin: EdgeInsets.only(top: 10),
             child: Text(
               '狮子王',
               style: TextStyle(
                 color: Colors.white,
               ),
             ),
           ),
         ],
       ),
     );
  }

  Widget _orderTitle(){
    return Container(
      margin:EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: KColor.detailTextColor
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.payment,
                  size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.send,
                  size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 30,
                ),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.comment,
                  size: 30,
                ),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myListTitle(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: KColor.defaultBorderColor,
          )
        )
      ),
      child: ListTile(
        leading: Icon(
          Icons.blur_circular,
        ),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券'),
          _myListTitle('已领取优惠券'),
          _myListTitle('地址管理'),
          _myListTitle('客户电话'),
          _myListTitle('关于我们'),

        ],
      ),
    );
  }
}

