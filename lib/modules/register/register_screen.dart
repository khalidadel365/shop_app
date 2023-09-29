import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../login/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Register_Screen extends StatelessWidget {
  Register_Screen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state) => {
          if(state is RegisterSuccessState){
            if(state.model.status==true){
              CacheHelper.saveData(key: 'token', value: state.model.data?.token)?.then(
                      (value){
                token = state.model.data?.token;
                print('&&&&&&&&&&&&&');
                print(token);
                navigateAndFinish(context, ShopLayout());
              })
            }else{
            showToast(
            message: state.model.message,
            state: ToastStates.ERROR),
            }
          }
        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(onPressed: (){
                navigateAndFinish(context, LoginScreen());
              },
                  icon: Icon(Icons.arrow_back_ios_sharp)),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),

                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),

                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          obsecureText: RegisterCubit.get(context).obsecure_text ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context)=> defaultButton(
                                text: 'REGISTER',
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                }),
                            fallback :(context)=> CircularProgressIndicator(),
                          ),
                        ),
                      ]
                      ,),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
