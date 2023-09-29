import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
                'Salla',
              style: TextStyle(
                color: Colors.black
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                      Icons.search_outlined,
                    color: Colors.black,
                  ))
            ],
          ),
          body: cubit.bottomScreens[cubit.current_Index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.current_Index,
              items: const[
                BottomNavigationBarItem(
                    icon: Icon(
                  Icons.home_outlined,
                ),label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                  Icons.apps_outlined,
                ),label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(
                  Icons.favorite_outline,
                ),label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(
                  Icons.settings_outlined,
                ),label: 'Settings'),
              ],
            onTap: (index){
                cubit.changeIndex(index);
            },
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
