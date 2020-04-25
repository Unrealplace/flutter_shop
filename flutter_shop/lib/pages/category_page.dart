import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/service/http_service.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/provide/category_provide.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CategoryPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.goodCategoryTitle),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftMenuPage(),
            Column(
              children: <Widget>[
                RightTopMenuPage(),
                GoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LeftMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeftMenuPage();
  }
}

class _LeftMenuPage extends State<LeftMenuPage> {

  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategoryMenu();

  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(
      builder: (context,child,val){
        //获取商品列表
        listIndex = val.firstCategoryIndex;

        return Container(
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1,
                color: KColor.defaultBorderColor,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index){
              return Text('${index}');
            },
          ),
        );
      },
    );
  }

  // 获取分类数据
  _getCategoryMenu() async {

    await request('getCategory',formData: null).then((val){
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });

      print(list);

      Provide.value<CategoryProvide>(context).getSecondCategory(list[0].secondCatrgoryVO, '4');
    });
  }

}

class RightTopMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RightTopMenuPage();
  }
}

class _RightTopMenuPage extends State<RightTopMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Text('xxxxx');
  }
}

class GoodsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodsList();
  }
}

class _GoodsList extends State <GoodsList> {
  @override
  Widget build(BuildContext context) {
    return Text('xxxxx');
  }
}

