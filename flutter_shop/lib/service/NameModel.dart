/// name : "liyang"

class NameModel {
  String _name;

  String get name => _name;

  NameModel(this._name);

  NameModel.map(dynamic obj) {
    this._name = obj["name"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    return map;
  }

}