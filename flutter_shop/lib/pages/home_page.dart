import 'package:flutter/material.dart';
import 'package:flutter_shop/config/index.dart';
import 'package:flutter_shop/service/http_service.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_shop/model/category_model.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/category_provide.dart';
import 'package:flutter_shop/provide/current_index_provide.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

// AutomaticKeepAliveClientMixin 防止当前页刷新
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 页数
  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<ClassicalFooterWidgetState> _footerKey =
      GlobalKey<ClassicalFooterWidgetState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('首页刷新了。。。。');
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    print('设备宽度:${ScreenUtil.screenWidth}');
    print('设备高度:${ScreenUtil.screenHeight}');
    print('设备的像素密度:${ScreenUtil.pixelRatio}');
    print('底部安全区距离:${ScreenUtil.bottomBarHeight}dp');
    print('状态栏高度:${ScreenUtil.statusBarHeight}dp');
    print('实际宽度的dp与设计稿px的比例:${ScreenUtil().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil().scaleHeight}');
    print(
        '宽度和字体相对于设计稿放大的比例:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}');
    print('高度相对于设计稿放大的比例:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}');
    print('系统的字体缩放比例:${ScreenUtil().scaleText}');
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      // futureBuilder 防止重绘
      body: FutureBuilder(
        future: request('homePageContent', formData: null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); //轮播
            List<Map> categoryList =
                (data['data']['category'] as List).cast(); //分类
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); //商品推荐
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //底部商品推荐
            Map fp1 = data['data']['floor1Pic']; //广告

            return EasyRefresh(
              footer: ClassicalFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: KColor.refreshTextColor,
                noMoreText: '',
                infoText: KString.loading,
                loadReadyText: KString.loadReadText,
                showInfo: true,
                infoColor: KColor.refreshTextColor,
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList),
                  TopNavigator(categoryList),
                  RecommendUI(recommendList),
                  FloorPic(fp1),
                  Floor(floor1),
                  _hotGoods(),
                ],
              ),
              onLoad: () async {
                _getHotGoods();
              },
            );
          } else {
            return Container(
              child: Center(
                child: Text(KString.noDataText),
              ),
            );
          }
        },
      ),
    );
  }

  void _getHotGoods() {
    var formPage = {'page':page};
    request('getHotGoods',formData: formPage).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      // 界面刷新
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
      print(data);
    });
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
          _wrapList(),
        ],
      ),
    );
  }

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 8.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5,color: KColor.defaultBorderColor),
      ),
    ),
    child: Text(
      KString.hotGoodsTitle,
      style: TextStyle(
        color: KColor.homeSubTitleTextColor,
      ),
    ),
  );

  // 火爆专区子项
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){

          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(375),
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['presentPrice']}',style: TextStyle(
                      color: KColor.presentPriceTextColor,
                    ),),
                    Text('￥${val['oriPrice']}',style: TextStyle(
                      color: KColor.oriPriceTextColor,
                    ),),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('not data');
    }
  }
}

// 首页轮播
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext cxt, int index) {
          return InkWell(
            onTap: () {},
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.all(5.0),
        ),
        autoplay: true,
      ),
    );
  }
}

// 首页分类导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator(this.navigatorList);

  // 跳转分类页面
  void _goCategory(context,index,String categoryId) async {
      await request('getCategory',formData: null).then((val){
        var data = json.decode(val.toString());
        CategoryModel categoryModel = CategoryModel.fromJson(data);
        List<Data> list = categoryModel.data;
        Provide.value<CategoryProvide>(context).changeFirstCategory(categoryId, index);
        Provide.value<CategoryProvide>(context).getSecondCategory(list[index].secondCategoryVO, categoryId);
        // 改变状态跳转页面
        Provide.value<CurrentIndexProvide>(context).changeIndex(1);
      });
  }

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        // 跳转分类页面
        _goCategory(context, index, item['firstCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['firstCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        physics: NeverScrollableScrollPhysics(), // 静止滚动
        children: navigatorList.map((item) {
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }
}

// 首页分类导航
class RecommendUI extends StatelessWidget {
  final List recommendList;
  RecommendUI(this.recommendList);

  // 标题
  Widget _titleWidget(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(width: 0.5, color: KColor.defaultBorderColor))),
      child: Text(
        KString.goodRecommendTitle,
        style: TextStyle(color: KColor.homeSubTitleTextColor),
      ),
    );
  }

  Widget _recommendList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _item(index, context);
        },
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
      ),
    );
  }

  Widget _item(index, context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: Container(
        width: ScreenUtil().setWidth(280),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          children: <Widget>[
            // 防止溢出
            Expanded(
              child: Image.network(
                recommendList[index]['image'],
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '￥${recommendList[index]['presentPrice']}',
              style: TextStyle(
                color: KColor.presentPriceTextColor,
              ),
            ),
            Text(
              '￥${recommendList[index]['oriPrice']}',
              style: KFont.oriPriceStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          _titleWidget(context),
          _recommendList(context),
        ],
      ),
    );
  }
}

// 推荐广告位
class FloorPic extends StatelessWidget {
  final Map floorPic;
  FloorPic(this.floorPic);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
      child: Container(
        child: InkWell(
          child: Image.network(
            floorPic['PICTURE_ADDRESS'],
            fit: BoxFit.contain,

          ),
          onTap: (){

          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      )

    );
  }
}

class Floor extends StatelessWidget {
  final List floor;
  Floor(this.floor);

  void jumpDetail(context, String goodId) {
    // 跳转商品详情
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.screenWidth;
   return Container(
     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       children: <Widget>[
         // 左侧商品
         Expanded(
           child: Column(
             children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0),
                  height: ScreenUtil().setHeight(450),
                  child: InkWell(
                    onTap: (){
                        jumpDetail(context, floor[0]['goodsId']);
                    },
                    child: Image.network(
                      floor[0]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                )
             ],
           ),
         ),
         // 右侧商品
         Expanded(
           child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                  height: ScreenUtil().setHeight(150),
                  width: (width - 24 ) / 2.0,
                  child: InkWell(
                    onTap: (){
                      jumpDetail(context, floor[2]['goodsId']);
                    },
                    child: Image.network(floor[2]['image'],fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                  height: ScreenUtil().setHeight(150),
                  width: (width - 24 ) / 2.0,
                  child: InkWell(
                    onTap: (){
                      jumpDetail(context, floor[3]['goodsId']);
                    },
                    child: Image.network(floor[3]['image'],fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
                  height: ScreenUtil().setHeight(150),
                  width: (width - 24 ) / 2.0,
                  child: InkWell(
                    onTap: (){
                      jumpDetail(context, floor[4]['goodsId']);
                    },
                    child: Image.network(floor[4]['image'],fit: BoxFit.cover,),
                  ),
                ),
              ],
           ),
         )
       ],
     ),
   );
  }
}

class HotGoodsUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  }
}