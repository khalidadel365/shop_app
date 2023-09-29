import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://student.valuxapps.com/api/',
       // receiveDataWhenStatusError: true,
      ),
    );
  }

    static Future<Response>? getData({
    required String url,
      Map<String, dynamic>? query,
      String? lang = 'en',
      String? token ,
  }){
      dio?.options.headers = {
        'lang' : lang,
        'Authorization': token ?? '',
        'Content-Type':'application/json'
      };
    return dio?.get(
        url,  //Method (Which table will get from)
        queryParameters: query
    );
  }

  static Future<Response>? postData({   //بيعمل request للapi انه يروح و معاه الdata دي
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token ,

  }){
    dio?.options.headers = {
      'lang' : lang,
      'Authorization': token??'',
      'Content-Type':'application/json'
    };

    return dio?.post(
      url, //request انا عاوز اروح لكزه و معايا الداتا دي
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response>? putData({   //بيعمل request للapi انه يروح و معاه الdata دي
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token ,

  }){
    dio?.options.headers = {
      'lang' : lang,
      'Authorization': token??'',
      'Content-Type':'application/json'
    };

    return dio?.put(
      url, //request انا عاوز اروح لكزه و معايا الداتا دي
      queryParameters: query,
      data: data,
    );
  }

}