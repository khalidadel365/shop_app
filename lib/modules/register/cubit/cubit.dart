import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix =  Icons.visibility_off_outlined;
  bool obsecure_text = true;
  LoginModel? model ;

   changePasswordVisibility(){
    obsecure_text = !obsecure_text;
    suffix = obsecure_text?  Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterChangePasswordVisibilityState());

  }

  void userRegister ({required String name , required String email, required String password,required String phone}){
    emit(RegisterLoadingState());
    DioHelper.postData(//بقول للAPI عاوز اروح للRegister اللي ف الDB (اللينك كله REQUEST)
        url: REGISTER,
        lang: 'en',
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        })?.then((value){
         model = LoginModel.fromJson(value.data);
          print(value.data);
          emit(RegisterSuccessState(model!));
    }).catchError((){
      emit(RegisterErrorState());
    });
  }
}




