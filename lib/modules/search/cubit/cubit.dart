import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() :super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void seach(String? text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text,
        },
        token: token,)?.then((value) {
          model = SearchModel.fromJson(value.data);
          print(model?.data?.data?[1].name);
          emit(SearchSuccessState());
    }
    ).catchError((error){
      print(error);
      emit(SearchErrorState());
  });
  }
}