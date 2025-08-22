import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cachelper.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/screens/login.dart';

import '../deffult.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context, ShopAppStates state) {},
      builder: (BuildContext context, ShopAppStates state) {
        var cubit=ShopAppCubit.get(context);
        var model=ShopAppCubit.get(context).userModel;
        var photo;
            if(model!=null){
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
          photo = model.data!.image!;
        }
        return BuildCondition(
          condition: model!=null,
          fallback:(context)=> Center(child: CircularProgressIndicator(),),
          builder: (context)=>SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Image(image: NetworkImage('${photo}'),),
                      radius: 60,
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                        prefix: Icons.person,
                        controller: nameController,
                        label: 'name',
                        type:TextInputType.name,
                         validator: (String? value){
                           if(value!.isEmpty){
                               return"name must not be empty";
                             }
                             return null;
                          }
                     ),
                    SizedBox(height: 20,),
                    defaultFormField(
                        prefix: Icons.email,
                        controller: emailController,
                        label: 'email',
                        type:TextInputType.name,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return"email must not be empty";
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 20,),
                    defaultFormField(
                        prefix: Icons.phone,
                        controller: phoneController,
                        label: 'phone',
                      type:TextInputType.name,
                        validator: (String? value){
                          if(value!.isEmpty){
                            return"phone must not be empty";
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 20,),
                    Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.deepOrange,
                        child: MaterialButton(
                            child: Text('update'),
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                {
                                  cubit.updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }
                            }
                        )
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      height: 50,
                        color: Colors.deepOrange,
                        child: MaterialButton(
                          child: Text('logout'),
                            onPressed: (){
                            CacheHelper.deleteData(key: 'token');
                            navigateToAndDelete(context: context,screen: LoginScreen());
                            }
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
