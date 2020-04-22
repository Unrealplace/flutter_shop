import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_shop/config/index.dart';

Future request(url,{formData})async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
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