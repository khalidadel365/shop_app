class LoginModel {
    bool? status;
    dynamic message;
    UserData? data ;

    LoginModel({this.status, this.message, this.data});
    LoginModel.fromJson(Map<String,dynamic> json){
      status = json['status'];
      message = json['message'];
      data = json['data'] != null ? UserData.fromJson(json['data']) : null;
   }

}

class UserData{
     dynamic id ;
     dynamic name;
     dynamic email;
     dynamic phone;
     dynamic image;
     dynamic points;
     dynamic credit;
     dynamic token;

   //named constructor
   UserData.fromJson(Map<String,dynamic> json){
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      points = json['points'];
      credit = json['credit'];
      token = json['token'];
   }

}
