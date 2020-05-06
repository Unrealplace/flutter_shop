/// code : "0"
/// message : "success"
/// data : {"goodInfo":{"amount":10000,"goodsId":"001","image1":"http://127.0.0.1:3000/images/goods/001/cover.jpg","goodsSerialNumber":"6901435325888","oriPrice":108.88,"presentPrice":98.88,"shopId":"402880e860166f3c0160167897d60002","goodsName":"法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙","goodsDetail":"<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/5.jpg\" />"}}

class DetailsModel {
  String code;
  String message;
  DataBean data;

  DetailsModel(this.code, this.message, this.data);

  DetailsModel.map(dynamic obj) {
    this.code = obj["code"];
    this.message = obj["message"];
    this.data = DataBean.map(obj["data"]);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = code;
    map["message"] = message;
    map["data"] = data.toMap();
    return map;
  }

}

/// goodInfo : {"amount":10000,"goodsId":"001","image1":"http://127.0.0.1:3000/images/goods/001/cover.jpg","goodsSerialNumber":"6901435325888","oriPrice":108.88,"presentPrice":98.88,"shopId":"402880e860166f3c0160167897d60002","goodsName":"法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙","goodsDetail":"<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/5.jpg\" />"}

class DataBean {
  GoodInfoBean goodInfo;

  DataBean(this.goodInfo);

  DataBean.map(dynamic obj) {
    this.goodInfo = GoodInfoBean.map(obj['goodInfo']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["goodInfo"] = goodInfo.toMap();
    return map;
  }

}

/// amount : 10000
/// goodsId : "001"
/// image1 : "http://127.0.0.1:3000/images/goods/001/cover.jpg"
/// goodsSerialNumber : "6901435325888"
/// oriPrice : 108.88
/// presentPrice : 98.88
/// shopId : "402880e860166f3c0160167897d60002"
/// goodsName : "法国代购新款江疏影同款翻领修身中长裙春夏印花连衣裙"
/// goodsDetail : "<img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/1.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/2.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/3.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/4.jpg\" /><img width=\"100%\" height=\"auto\" alt=\"\" src=\"http://127.0.0.1:3000/images/goods/001/5.jpg\" />"

class GoodInfoBean {
  int amount;
  String goodsId;
  String image1;
  String goodsSerialNumber;
  double oriPrice;
  double presentPrice;
  String shopId;
  String goodsName;
  String goodsDetail;

  GoodInfoBean(this.amount, this.goodsId, this.image1, this.goodsSerialNumber, this.oriPrice, this.presentPrice, this.shopId, this.goodsName, this.goodsDetail);

  GoodInfoBean.map(dynamic obj) {
    this.amount = obj["amount"];
    this.goodsId = obj["goodsId"];
    this.image1 = obj["image1"];
    this.goodsSerialNumber = obj["goodsSerialNumber"];
    this.oriPrice = obj["oriPrice"];
    this.presentPrice = obj["presentPrice"];
    this.shopId = obj["shopId"];
    this.goodsName = obj["goodsName"];
    this.goodsDetail = obj["goodsDetail"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["amount"] = amount;
    map["goodsId"] = goodsId;
    map["image1"] = image1;
    map["goodsSerialNumber"] = goodsSerialNumber;
    map["oriPrice"] = oriPrice;
    map["presentPrice"] = presentPrice;
    map["shopId"] = shopId;
    map["goodsName"] = goodsName;
    map["goodsDetail"] = goodsDetail;
    return map;
  }

}