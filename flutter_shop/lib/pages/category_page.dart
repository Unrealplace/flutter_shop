import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/service/http_service.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:flutter_shop/provide/category_provide.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/model/category_goods_list_model.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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


// 左侧的菜单
class LeftMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeftMenuPage();
  }
}

class _LeftMenuPage extends State<LeftMenuPage> {

  List<Data> list = [];
  // 默认选择的索引
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    // 发起网络请求获取菜单数据
    _getCategoryMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(
      builder: (context,child,val){
        // provide 数据index 发生变化调用
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
              return _leftInkWell(index);
            },
          ),
        );
      },
    );
  }


  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    
    return InkWell(
      onTap: (){
        var secondCategoryList = list[index].secondCategoryVO;
        var firstCategoryId = list[index].firstCategoryId;
        Provide.value<CategoryProvide>(context).changeFirstCategory(firstCategoryId, index);
        Provide.value<CategoryProvide>(context).getSecondCategory(secondCategoryList, firstCategoryId);
        _getGoodList(context,firstCategoryId: firstCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(90),
        padding: EdgeInsets.only(left: 8.0,top: 8.0),
        decoration: BoxDecoration(
          color: isClick ? Colors.cyanAccent : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: KColor.defaultBorderColor
            )
          ),
        ),
        child: Text(
          list[index].firstCategoryName,
          style: TextStyle(
            color: isClick ? KColor.primaryColor : Colors.black,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
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

      Provide.value<CategoryProvide>(context).getSecondCategory(list[0].secondCategoryVO, '4');
    });
  }

  _getGoodList(context,{String firstCategoryId}) {
    var data = {
      'firstCategoryId':firstCategoryId == null ? Provide.value<CategoryProvide>(context).firstCategoryId : firstCategoryId,
      'secondCategoryId':Provide.value<CategoryProvide>(context).secondCategoryId,
      'page':1,
    };

    request('getCategoryGoods',formData: data).then((val){

      var data = json.decode(val.toString());
      print(data.toString());
      CategoryGoodsListModel goodsListModel = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsListModel.data);

    });
  }

}


// 右侧头部导航
class RightTopMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RightTopMenuPage();
  }
}

class _RightTopMenuPage extends State<RightTopMenuPage> {


  Widget _rightTopInkWell(int index, SecondCategoryVO item) {
    bool isClick = false;
    isClick = (index == Provide.value<CategoryProvide>(context).secondCategoryIndex) ? true : false;

    return InkWell(
      onTap: (){
        Provide.value<CategoryProvide>(context).changeSecondIndex(index, item.secondCategoryId);
        _getGoodList(context,secondCategoryId: item.secondCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(90),
        padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        decoration: BoxDecoration(
          color: isClick ? Colors.cyanAccent : Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 2,
                  color: KColor.defaultBorderColor
              )
          ),
        ),
        child: Text(
          item.secondCategoryName,
          style: TextStyle(
            color: isClick ? KColor.primaryColor : Colors.black,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  _getGoodList(context,{String secondCategoryId}) {
    var data = {
      'secondCategoryId':secondCategoryId == null ? Provide.value<CategoryProvide>(context).secondCategoryId : secondCategoryId,
      'page':1,
    };

    request('getCategoryGoods',formData: data).then((val){

      var data = json.decode(val.toString());
      print(data.toString());
      CategoryGoodsListModel goodsListModel = CategoryGoodsListModel.fromJson(data);
      if (goodsListModel.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsListModel.data);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<CategoryProvide>(
        builder: (context,child,categoryProvide){
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: KColor.defaultBorderColor,
                )
              )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProvide.categoryGoodList.length,
                itemBuilder:(context,index){
                  return _rightTopInkWell(index, categoryProvide.categoryGoodList[index]);
                }
            ),
          );
        },
      ),
    );
  }
}

class GoodsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodsList();
  }
}

class _GoodsList extends State <GoodsList> {
  GlobalKey<ClassicalFooterWidgetState> _footKey = GlobalKey<ClassicalFooterWidgetState>();
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data) {
        try {
          // 分类切换时滚动到顶部
            if (Provide.value<CategoryProvide>(context).page == 1){
              scrollController.jumpTo(0.0);
            }
        } catch (e) {

        }
        
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  key: _footKey,
                  bgColor: Colors.white,
                  textColor: KColor.refreshTextColor,
                  infoColor: KColor.refreshTextColor,
                  showInfo: true,
                  noMoreText: Provide.value<CategoryProvide>(context).noMoreText,
                  loadReadyText: KString.loadReadText,
                ),
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: data.goodsList.length,
                      itemBuilder: (context,index) {
                        return Text('${index}');
                      }
                  )
              ),
            ),
          );
        } else {
          return null;
        }
        
      },
    );
  }

  Widget _ListWidget(List newList,int index) {

    return InkWell(
      onTap: (){
        // TODO

      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: KColor.defaultBorderColor,
            )
          )
        ),
        child: Row(
          children: <Widget>[
            Column(

            ),
          ],
        ),
      ),

    );
  }
}

