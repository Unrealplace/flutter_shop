
import 'package:flutter/material.dart';
import '../../provide/detail_info_provide.dart';
import '../../config/index.dart';
import 'package:flutter_screenutil/screenutil.dart';

// 商品详情页说明
class DetailsExpain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      width: ScreenUtil().setWidth(750),
      child: Text(
        KString.detailsPageExplain,
        style: TextStyle(
          color: Colors.red,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }
}