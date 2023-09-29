import 'dart:convert';

class CategoriesModel{
  bool? status ;
  dynamic message;
  Categories_Data? categories_data ;


  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    categories_data = Categories_Data.fromJson(json['data']);
  }

}

class Categories_Data {
  int? current_page;
  List<Data> data=[];
  dynamic first_page_url;
  dynamic from;
  dynamic last_page;
  dynamic last_page_url;
  dynamic next_page_url;
  dynamic path;
  dynamic per_page;
  dynamic prev_page_url;
  dynamic to;
  dynamic total;
  Categories_Data.fromJson(Map<String,dynamic>json){
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(Data.fromJson(element));

    });
  }
}

class Data {
  int? id;
  dynamic name;
  dynamic image;

  Data.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}