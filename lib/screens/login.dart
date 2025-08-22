import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cachelper.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/models/model.dart';
import 'package:shopapp/screens/regester.dart';
import '../deffult.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if(state is AppSuccessState){
          if(state.loginModel.status!){
            CacheHelper.setData(value: state.loginModel.data!.token, key: "token").then((value)
            {
              token=state.loginModel.data!.token;
              navigateToAndDelete(
                  screen: HomeScreen(),
                  context: context);
              ShopAppCubit.get(context).currentIndex=0;
              ShopAppCubit.get(context).getHomeData();
              ShopAppCubit.get(context).getUserData();
              ShopAppCubit.get(context).getFavoriteData();
            }
            );
          }else{
            print(state.loginModel.message);
            FlutterToastr.show(
                '${state.loginModel.message}',
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
                      Text('Login now to brows our hot offers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
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
                    state is! AppLoadingState ?
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          child:  Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          height: 50,
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                             },
                          color: Colors.deepOrange,
                        ),
                      ): Center(child: CircularProgressIndicator()),
                       SizedBox(height: 20,),
                      Row(
                        children: [
                           Text('Don\'t have an account now',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                           SizedBox(width: 20,),
                          TextButton(
                            onPressed: (){
                             navigateTo(screen: regesterScreen(), context: context);
                            },
                            child:  Text('REGISTER',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 16,
                              ),
                            ),
                          ),
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
    );
  }
}
