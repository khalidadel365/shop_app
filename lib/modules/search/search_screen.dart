import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search_outlined,
                    onSubmit: (text){
                      SearchCubit.get(context).seach(searchController.text);
                    },
                    validate: (value)
                    {
                      if(value.isEmpty){
                        return 'enter text to search';
                      }
                      else{
                        return null;
                      }
                    }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingState)
                  LinearProgressIndicator(),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: Container(
                      height: 200,
                      child: ListView.separated(
                             physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index) => buildSearchItem(SearchCubit.get(context).model!.data!.data![index],context,
                          searchController.text),// عشان يسيرش تاني لما يدوس علي انه يشيله من الfav),
                          separatorBuilder: (context,index)=> myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
Widget buildSearchItem(Product model ,context,String? text) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Image(
          image: NetworkImage(
            '${model.image}',
          ),

          width: 120,
          height: 120,
          // fit: BoxFit.cover, comment عشان الصورة كلها تبقي كامله مش مقصوصة
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column( //عشان اديهم هما بس padding
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
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
                    '${model.price}',
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
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 10
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
                      child: IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavorites(model.id);
                            SearchCubit.get(context).seach(text);
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
