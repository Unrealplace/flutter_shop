import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_shop/config/index.dart';
import 'package:dio/adapter.dart';

Future request(url,{formData})async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();

    // 配置网络代理
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 192.168.1.103:8888";
      };
      // you can also create a new HttpClient to dio
      // return new HttpClient();
    };
    if(formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url],data: formData);
    }

    if (response.statusCode == 200) {
      return response;
    } else {
      return Exception("后端接口异常。。。");
    }

  } catch (e) {
    return print('error::${e}');
  }
}