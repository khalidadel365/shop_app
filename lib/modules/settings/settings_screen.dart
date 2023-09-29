import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();
  var  formKey = GlobalKey<FormState>();

  @override

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessGetProfileState){
          print(state.userModel?.data?.name);
          print(state.userModel?.data?.email);
          print(state.userModel?.data?.phone);
          nameController.text = state.userModel?.data?.name;
          emailController.text = state.userModel?.data?.email;
          phoneController.text = state.userModel?.data?.phone;
        }
      },
      builder: (context,state){
        LoginModel? model = ShopCubit.get(context).userModel;
        nameController.text = model?.data?.name;
        emailController.text = model?.data?.email;
        phoneController.text = model?.data?.phone;
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!= null,
          builder: (context) => Padding (
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person,
                    validate:(value){
                      if(value.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.name,
                    label: 'Email Address',
                    prefix: Icons.email,
                    validate:(value){
                      if(value.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone,
                    validate:(value){
                      if(value.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(text: 'update', onPressed: (){
                    if(formKey.currentState!.validate()){
                      ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      );
                    }
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      text: 'Logout', onPressed: (){
                        ShopCubit.get(context).homeModel = null;
                        ShopCubit.get(context).favorites.clear();
                        print('^^^^^^^^^^^^^^^^^^^^logout');
                        print(token);
                        signOut(context);
                  })
                ],
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(),
        );
      },
    );
  }
}
