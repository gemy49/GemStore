class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data= CategoriesDataModel.fromjson(json['data']);
  }
}
class CategoriesDataModel{
  int? current_page;
  List<CategoriesData> data=[];
  CategoriesDataModel.fromjson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element) {
      data.add(CategoriesData.fromjson(element));
    });
  }
}
class CategoriesData{
int? id;
String? name;
String? image;
  CategoriesData.fromjson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}