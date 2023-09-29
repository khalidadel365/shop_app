class  HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);

  }
}

class HomeDataModel {
  List<BannerModel> banners =[];
  List<ProductModel> products =[];
  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    // print('__________________');
    // print(banners[0].id);
    // print(banners[1].id);
    // print(banners[2].id);
    // print('__________________');
    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    }
    );
  }
}
class BannerModel {
  dynamic id ;
  dynamic image;

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}
class ProductModel {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    id = json['id'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}