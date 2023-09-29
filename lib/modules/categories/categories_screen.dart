import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)=> ListView.separated(
        itemBuilder: (context,index) =>  buildCategoriesItem(ShopCubit.get(context).categories_model!.categories_data!.data[index]),
        separatorBuilder: (context,index) => myDivider(),
        itemCount: ShopCubit.get(context).categories_model!.categories_data!.data.length,
      ),
    );
  }

  Widget buildCategoriesItem(Data model) =>  Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
              '${model.image}'
          ),
          width: 80,
          height: 80,
          fit: BoxFit.cover ,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
