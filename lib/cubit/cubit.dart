import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/dio/dio.dart';
import 'package:shopapp/dio/endpoint.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/favorite_model.dart';
import 'package:shopapp/models/favoritecangemodel.dart';
import 'package:shopapp/screens/favorite.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/screens/settings.dart';
import 'package:shopapp/screens/shophome.dart';
import '../cachelper.dart';
import '../screens/category.dart';
import '../models/model.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{
  ShopAppCubit() : super(AppInitialState());
  static ShopAppCubit get(context)=>BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
}){
    emit(AppLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password':password,
        }
    ).then((value) {
    loginModel=LoginModel.dataFromJson(value.data);

      emit(AppSuccessState(loginModel!));
    }).catchError((error){
      emit(AppErrorState(error.toString()));
      print('error is ${error.toString()}');
    });
  }
  LoginModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
          'password':password,
          'name':name,
          'phone':phone,
        }
    ).then((value) {
      registerModel=LoginModel.dataFromJson(value.data);

      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
      print('error is ${error.toString()}');
    });
  }
IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changeSuffix(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off_outlined;
emit(PasswordChangeState());
  }
  List<Widget>screens=[
  ProductsScreen(),
  CategoryScreen(),
  FavoriteScreen(),
  SettingsScreen()
  ];
  var currentIndex=0;
  void BottomNave(index){
    currentIndex=index;
    emit(BottomNaveChangeState());
  }
  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopHomeLoadingState());
DioHelper.getData(url: HOME,token: token).then((value) {
  homeModel=HomeModel.fromJson(value.data);
  homeModel!.data!.products!.forEach((element) {
    favorites.addAll({
    element.id!:element.in_favorites!
    });
  });
      emit(ShopHomeSuccessState());
        }
        ).catchError((error){
  print('error is ${error}');
  emit(ShopHomeErrorState(error));
});
  }
  CategoriesModel? categoriesModel;
  void getcategoriesData(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel=CategoriesModel.fromjson(value.data);
      emit(ShopCategoriesSuccessState());
    }
    ).catchError((error){
      print('error is ${error}');
      emit(ShopCategoriesErrorState(error));
    });
  }

    Map<int,bool>favorites={};
   FavoriteChangeModel? favoriteChangeModel;
  void postFavoriteData(productId){
     favorites[productId]=!favorites[productId]!;
     emit(ShopFavoriteChangeSuccessState(favoriteChangeModel));
    DioHelper.postData(
        url: FAVORITE,
        data: {
          'product_id':productId
        },
        token: token
    ).then((value) {
      favoriteChangeModel=FavoriteChangeModel.fromJson(value.data);
      if(!favoriteChangeModel!.status!){
        favorites[productId]=!favorites[productId]!;
       }else {
         getFavoriteData();
       }
      emit(ShopFavoriteSuccessState());
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ShopFavoriteErrorState(error));
    });
  }

  FavoritesModel? favoriteModel;
  void getFavoriteData(){
    emit(ShopGetFavoriteChangeLoadingState());
    DioHelper.getData(
        url: FAVORITE,
        token: token
    ).then((value) {
      favoriteModel=FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoriteChangeSuccessState(favoriteModel));
    }
    ).catchError((error){
      print('error is ${error}');
      emit(ShopGetFavoriteErrorState(error));
    });
  }


  LoginModel? userModel;
  void getUserData(){
    emit(ShopUserLoadingState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userModel=LoginModel.dataFromJson(value.data);
      emit(ShopUserSuccessState(userModel));
    }
    ).catchError((error){
      print('error is ${error}');
      emit(ShopUserErrorState(error));
    });
  }

  void updateUserData({
   String? name,
   String? email,
   String? phone,
}){
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
        url: UpdateProfile,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        }).then((value) {
        userModel = LoginModel.dataFromJson(value.data);
        print(userModel!.message);
        emit(ShopUpdateProfileSuccessState(userModel));
    }
    ).catchError((error){
      print('error is ${error}');
      emit(ShopUpdateProfileErrorState(error));
    });
  }
}