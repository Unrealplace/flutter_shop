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
          _myListTitle(),
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
                 child: Image.asset('assets/images/girl.png',fit: BoxFit.cover,),
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
           )
         ],
       ),
     );
  }

  Widget _orderTitle(){
    return Container(

    );
  }

  Widget _orderType(){
    return Container(

    );
  }

  Widget _myListTitle(){
    return Container(

    );
  }
}

