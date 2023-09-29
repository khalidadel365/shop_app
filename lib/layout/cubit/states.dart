import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class AppChangeBotttomSheetState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopLoadingCategoriesState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoriteState extends ShopStates{}

class ShopSuccessChangeFavoriteState extends ShopStates{
  late final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopSuccessGetFavoriteState extends ShopStates{}

class ShopLoadingGetFavoriteState extends ShopStates{}

class ShopErrorGetFavoriteState extends ShopStates{}

class ShopSuccessGetProfileState extends ShopStates{
  LoginModel? userModel;
  ShopSuccessGetProfileState(this.userModel);
}

class ShopLoadingGetProfileState extends ShopStates{}

class ShopErrorGetProfileState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{
  LoginModel? userModel;
  ShopSuccessUpdateUserState(this.userModel);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}

