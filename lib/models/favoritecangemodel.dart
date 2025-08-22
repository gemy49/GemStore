class FavoriteChangeModel{
  bool? status;
  String? message;
  FavoriteChangeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}