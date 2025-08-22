import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/deffult.dart';

import '../cachelper.dart';
import 'home.dart';

class regesterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if(state is ShopRegisterSuccessState){
          if(state.model.status!){
            CacheHelper.setData(value: state.model.data!.token, key: "token").then((value)
            {
              token=state.model.data!.token;
              navigateToAndDelete(
                  screen: HomeScreen(),
                  context: context);
            }
            );
          }else{
            print(state.model.message);
            FlutterToastr.show(
              '${state.model.message}',
              context,
              duration: FlutterToastr.lengthLong,
              position:  FlutterToastr.bottom,
              backgroundColor: Colors.red,


            );
          }
        }
      },
      builder: (context,state){
        var cubit =ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('signup now to brows our hot offers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ), SizedBox(height: 40,),
                      defaultFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter a name';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        controller: nameController,
                        prefix: Icons.person,
                        label: 'name',
                      ),
                      SizedBox(height: 40,),
                      defaultFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter a email';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        controller: emailController,
                        prefix: Icons.email,
                        label: 'Email',
                      ), SizedBox(height: 40,),
                      defaultFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter a phone';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        controller: phoneController,
                        prefix: Icons.phone,
                        label: 'phone',
                      ),
                      SizedBox(height: 40,),
                      defaultFormField(
                          isPassword: cubit.isPassword,
                          validator: (value){
                            if(value.isEmpty){
                              return 'pleas enter an password';
                            }
                            return null;
                          },
                          type: TextInputType.text,
                          controller: passwordController,
                          prefix: Icons.lock,
                          label: 'password',
                          suffix:cubit.suffix,
                          function: (){
                            cubit.changeSuffix();
                          }
                      ),
                      SizedBox(height: 40,),
                      state is! ShopRegisterLoadingState ?
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          child:  Text('signup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          height: 50,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                              );
                            }
                          },
                          color: Colors.deepOrange,
                        ),
                      ): Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  }
