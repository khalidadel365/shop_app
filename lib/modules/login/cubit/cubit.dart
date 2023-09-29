import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../layout/cubit/states.dart';
import '../../../models/categories_model.dart';
import '../../../models/get_favorites_model.dart';
import '../../../models/home_model.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix =  Icons.visibility_off_outlined;
  bool obsecure_text = true;
  LoginModel? model ;

   changePasswordVisibility(){
    obsecure_text = !obsecure_text;
    suffix = obsecure_text?  Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(changePasswordVisibilityState());

  }

  void userLogin ({required String email, required String password,context}){
    emit(LoginLoadingState());
    DioHelper.postData(//بقول للAPI عاوز اروح للLOGIN اللي ف الDB (اللينك كله REQUEST)
        url: LOGIN,
        lang: 'en',
        data: {
          'email':email,
          'password':password,
        })?.then((value){
         model = LoginModel.fromJson(value.data);
          print(value.data);
          emit(LoginSuccessState(model!));
    }).catchError((){
      emit(LoginErrorState());
    });
  }


}




