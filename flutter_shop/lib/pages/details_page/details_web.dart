
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/detail_info_provide.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

// 商品详细评论切换
class DetailsWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var goodsDetailInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetailInfo,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text(
              '暂无更多数据',
            ),
          );
        }
      },
    );
  }

}