import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/get_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int current_Index = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    current_Index = index;
    emit(ShopChangeBottomNavBarState());
  }


  HomeModel? homeModel;
  Map<int,dynamic> favorites ={};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
        token: token,
       )?.then((value){
         //print(value.data);
         homeModel = HomeModel.fromJson(value.data);
         //print(homeModel?.data?.banners[0].id);
         homeModel!.data!.products.forEach((element) {
           favorites.addAll(
             {
               element.id : element.inFavorites,
             }
           );
         });
         print(favorites);
         //print(favorites);
         emit(ShopSuccessHomeDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });


}
  CategoriesModel? categories_model;
  void getCategories (){
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    )?.then((value){
      categories_model = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId ,){
    favorites[productId!] = !favorites[productId];  //بعدل علي الList اللي موجودة اصلا  عشان لما اعمل emit
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
      token: token,
    )?.then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          if(changeFavoritesModel?.status == false){ // عشان لو حصل حاجة و متغيرش اللون لو اتغير يرجع زي ما كان
            favorites[productId] = !favorites[productId];
          }
          else{
            getFavorites();
          }
          //print(value.data);
          emit(ShopSuccessChangeFavoriteState(changeFavoritesModel!));
    }).catchError((){
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoriteState());
    });
  }
  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    )?.then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print(value.data);
      //print('*************2*');
      //print(favoritesModel?.data?.data?[1].product?.name);
      //print(favoritesModel?.data?.data?[1].product?.price);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((){
      emit(ShopErrorGetFavoriteState());
    });
  }
  LoginModel? userModel;
  void getProfile(){
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
    )?.then((value){
      //print(value.data);
      userModel = LoginModel.fromJson(value.data);
      print(userModel?.data?.email);
      emit(ShopSuccessGetProfileState(userModel));
    }).catchError((error){
      emit(ShopErrorGetProfileState());
    });
  }
  void updateUserData({required String name,required String email,required String phone,}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: token,
    )?.then((value){
      //print(value.data);
      userModel = LoginModel.fromJson(value.data);
      print(userModel?.data?.email);
      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error){
      emit(ShopErrorUpdateUserState());
    });
  }

}