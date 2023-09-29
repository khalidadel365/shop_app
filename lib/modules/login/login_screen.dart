import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController email_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener:(BuildContext context, state) {
          if(state is LoginSuccessState){
            if(state.model.status==true){
               CacheHelper.saveData(
                   key: 'token',
                   value: state.model.data?.token)?.then(
                       (value) {
                         token = state.model.data?.token;
                         print('&&&&&&&&&&&&&');
                         print(token);
                         ShopCubit.get(context).getHomeData();
                         ShopCubit.get(context).getCategories();
                         ShopCubit.get(context).getProfile();
                         ShopCubit.get(context).changeIndex(0); // يبتدى الapp من اول سكرين
                         navigateAndFinish(context, ShopLayout());
                       }
                       );
              showToast(
                  message: state.model.message,
                  state: ToastStates.SUCCESS);
              print(state.model.data?.token);
            }else{
              showToast(
                  message: state.model.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),

                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),

                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: email_controller,
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
                          controller: password_controller,
                          type: TextInputType.visiblePassword,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                email: email_controller.text,
                                password: password_controller.text,
                              );
                            }
                          },
                          obsecureText: LoginCubit.get(context).obsecure_text ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=> defaultButton(
                                text: 'LOGIN',
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(
                                        email: email_controller.text,
                                        password: password_controller.text,
                                    );
                                  }
                                }),
                            fallback :(context)=> CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, Register_Screen());
                                }, text: 'register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
