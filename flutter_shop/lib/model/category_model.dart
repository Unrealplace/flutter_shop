class CategoryModel {
  String code;
  String message;
  List<Data> data;
  CategoryModel(this.code,this.message,this.data);

  CategoryModel.fromJson(Map<String,dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<Data>();
      json['data'].forEach((v){
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map();
    data['code'] = this.code;
    data['message'] = this.message;
    if(this.data != null) {
      data['data'] = this.data.map((v){
        v.toJson();
      }).toList();
    }

    return data;
  }
}

class Data {
  String firstCategoryId;
  String firstCategoryName;
  List<SecondCategoryVO> secondCategoryVO;
  Null comments;
  String image;

  Data(this.firstCategoryId, this.firstCategoryName, this.secondCategoryVO,this.comments,this.image);

  Data.fromJson(Map<String,dynamic> json) {
    firstCategoryId = json['firstCategoryId'];
    firstCategoryName = json['firstCategoryName'];
    comments = json['comments'];
    image = json['image'];

    if (json['secondCategoryVO'] != null) {
      secondCategoryVO = List<SecondCategoryVO>();
      json['secondCategoryVO'].forEach((v){
        secondCategoryVO.add(SecondCategoryVO.fromJson(v));
      });
    }
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map();
    data['firstCaegoryId'] = this.firstCategoryId;
    data['firstCategoryName'] = this.firstCategoryName;
    data['comments'] = this.comments;
    data['image'] = this.image;

    if(this.secondCategoryVO != null) {
      data['secondCategoryVO'] = this.secondCategoryVO.map((v){
        v.toJson();
      }).toList();
    }

    return data;
  }
}


class SecondCategoryVO {
  String firstCategoryId;
  String secondCategoryId;
  String secondCategoryName;
  String comments;


  SecondCategoryVO(this.firstCategoryId, this.secondCategoryId,
      this.secondCategoryName, this.comments);

  SecondCategoryVO.fromJson(Map<String, dynamic> json) {
    firstCategoryId = json['firstCategoryId'];
    secondCategoryId = json['secondCategoryId'];
    secondCategoryName = json['secondCategoryName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data['firstCategoryId'] = this.firstCategoryId;
    data['secondCategoryId'] = this.secondCategoryId;
    data['comments'] = this.comments;
    data['secondCategoryName'] = this.secondCategoryName;

    return data;
  }

}

