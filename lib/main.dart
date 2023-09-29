import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

void main() async{
  bool? onBoarding ;
  Widget? widget ;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(onBoarding);
  print("IIIIIIIIIIIIIIIIIIII");
  print(token);

  //*****************************
  if(onBoarding!=null){
    if(token !=null) widget = ShopLayout();
    else widget = LoginScreen();
  }
  else{
    widget = OnBoardingScreen();
  }
  //*****************************
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp(
      onBoarding,
      widget,
  ));
}

class MyApp extends StatelessWidget {
  dynamic onBoarding;
  Widget? startWidget;
  MyApp(this.onBoarding,this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile()),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            home:  startWidget,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    );
  }
}
