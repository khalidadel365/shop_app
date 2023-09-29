import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../models/get_favorites_model.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print('initttttt');
    ShopCubit.get(context).getFavorites();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context , state){},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoriteState,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) => buildFavoriteItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
                separatorBuilder: (context , index) => myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      }
    );
  }

  Widget buildFavoriteItem(FavoritesData? model ,context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  '${model?.product?.image}',
                ),

                width: 120,
                height: 120,
                // fit: BoxFit.cover, comment عشان الصورة كلها تبقي كامله مش مقصوصة
              ),
              if(model?.product?.discount != 0)
                Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:5,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 10.5,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column( //عشان اديهم هما بس padding
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model?.product?.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Row (
                  children: [
                    Text(
                      '${model?.product?.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: defaultColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(model?.product?.discount !=0)
                      Text(
                        '${model?.product?.discount}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model?.product?.id] ? defaultColor : Colors.grey,
                        child: IconButton(
                            onPressed: (){
                              ShopCubit.get(context).changeFavorites(model?.product?.id);
                              //print(model?.id);
                            },
                            icon: const Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                              size: 14,
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
