import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/provide/current_index_provide.dart';
import 'package:flutter_screenutil/screenutil.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(KString.homeTitle),//首页
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      title: Text(KString.catecoryTitle),//分类
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),//购物车
      title: Text(KString.shopCarTitle),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person ),
      title: Text(KString.memberTitle),//会员中心
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width:750.0,height:1334.0)..init(context);

    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        // 取到当前索引状态值
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;

        //因为Scaffold是一个Material的组件，但是最外层必须返回一个MaterialApp
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items: bottomTabs,
              onTap: (index) {
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: tabBodies,
            ),
          ),
        );
      }
    );
  }
}