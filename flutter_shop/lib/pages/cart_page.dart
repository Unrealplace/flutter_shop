import 'package:flutter/material.dart';
import '../config/index.dart';
import '../provide/cart_provide.dart';
import 'package:provide/provide.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.shopCarTitle),
      ),
      body: FutureBuilder(
          builder: (context,snapshot){
            if(snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context,child,scope){
                      List cartList = Provide.value<CartProvide>(context).cartList;
                      if (cartList.length > 0) {
                        return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context,index){
                            return CartItem(cartList[index]);
                          },
                        );
                      } else {
                        return Center(
                          child: Text('暂无数据~'),
                        );
                      }
                      
                    },
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: CartBottom(),
                  ),
                ],
              );
            } else {
              return Text(KString.loading);
            }
          },
        future: _getCartInfo(),
      ),
    );
  }

  Future _getCartInfo()async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}