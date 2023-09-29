import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/constants.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if(ShopCubit.get(context).homeModel == null && isOpened == true){ //عشان لما يعمل log out و يرجع يخش ميلاقيش نفس الداتا
      ShopCubit.get(context).getHomeData();
      ShopCubit.get(context).getCategories();
      ShopCubit.get(context).getProfile();
      print(' 2عملت get تاني');
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoriteState){ //لو الvariable من نوع ShopSuccessState
          if(state.model.status == false){
            showToast(
                message: '${state.model.message}',
                state: ToastStates.ERROR);
          }
          if(state.model.status == true){
            showToast(
                message: '${state.model.message}',
                state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          // بلاش اعمل الcondition علي الstate الاحسن يكون ب حاجة ثابتة
            condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categories_model != null,
            builder: (context) => productsBuilder(ShopCubit.get(context).homeModel , ShopCubit.get(context).categories_model!,context),
            fallback: (context) =>Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model ,CategoriesModel categories_Model,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model?.data?.banners.map((e) => Image(
                image: NetworkImage(e.image),
                width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 220,
              viewportFraction: 1 , //الصورتين واخدين العرض كله
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,

            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                 'Categories',
                 style: TextStyle(
                 fontWeight: FontWeight.bold,
                   fontSize: 24,
               ),),
              SizedBox(
                height: 10,
              ),
              Container (
                 height: 100,
                 child: ListView.separated(
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context ,index) => buildCategoryItem(categories_Model.categories_data!.data[index]),
                     separatorBuilder: (context ,index) => SizedBox(
                       width: 10,
                     ),
                     itemCount: ShopCubit.get(context).categories_model!.categories_data!.data.length),
               ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
              crossAxisCount: 2,
            shrinkWrap: true, //************************************************************************
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1,
            crossAxisSpacing: 2,
            childAspectRatio: 1 / 1.621 , //طول و عرض الصور
            children: List.generate(
                model!.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context) ),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProduct(ProductModel? model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage(
                  model?.image,
                ),
                width: double.infinity,
                height: 190,
               // fit: BoxFit.cover, comment عشان الصورة كلها تبقي كامله مش مقصوصة
            ),
            if(model?.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column( //عشان اديهم هما بس padding
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model?.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row (
                children: [
                  Text(
                    '${model?.price}',
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
                  if(model?.discount != 0)
                    Text(
                      '${model?.oldPrice}',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favorites[model?.id] ? defaultColor : Colors.grey,
                    child: IconButton(
                         onPressed: (){
                           ShopCubit.get(context).changeFavorites(model?.id);
                           print(model?.id);
                         },
                        icon: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                          size: 14,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(Data categories_Model) => Container(
    height: 100,
    width: 100,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children:  [
         Image(
          image: NetworkImage(categories_Model.image),
          width: 100 ,
          height: 100 ,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            '${categories_Model.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
