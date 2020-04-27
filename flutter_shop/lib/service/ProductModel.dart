/// code : "200"
/// data : [{"product":{"productId":"11123","productName":"name"}}]

class ProductModel {
  String _code;
  List<DataBean> _data;

  String get code => _code;
  List<DataBean> get data => _data;

  ProductModel(this._code, this._data);

  ProductModel.map(dynamic obj) {
    this._code = obj["code"];
    this._data = obj["data"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = _code;
    map["data"] = _data;
    return map;
  }

}

/// product : {"productId":"11123","productName":"name"}

class DataBean {
  ProductBean _product;

  ProductBean get product => _product;

  DataBean(this._product);

  DataBean.map(dynamic obj) {
    this._product = obj["product"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["product"] = _product;
    return map;
  }

}

/// productId : "11123"
/// productName : "name"

class ProductBean {
  String _productId;
  String _productName;

  String get productId => _productId;
  String get productName => _productName;

  ProductBean(this._productId, this._productName);

  ProductBean.map(dynamic obj) {
    this._productId = obj["productId"];
    this._productName = obj["productName"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["productId"] = _productId;
    map["productName"] = _productName;
    return map;
  }

}