import 'package:shopapp/models/favorite_model.dart';
import 'package:shopapp/models/favoritecangemodel.dart';
import 'package:shopapp/models/model.dart';

abstract class ShopAppStates{}

class AppInitialState extends ShopAppStates{}
class AppLoadingState extends ShopAppStates{}
class AppSuccessState extends ShopAppStates{
  final LoginModel loginModel;

  AppSuccessState(this.loginModel);
}
class AppErrorState extends ShopAppStates{
  final String error;

  AppErrorState(this.error);

}

class PasswordChangeState extends ShopAppStates{}

class BottomNaveChangeState extends ShopAppStates{}

class ShopHomeLoadingState extends ShopAppStates{}
class ShopHomeSuccessState extends ShopAppStates{}
class ShopHomeErrorState extends ShopAppStates{
  final String error;

  ShopHomeErrorState(this.error);

}


class ShopCategoriesLoadingState extends ShopAppStates{}
class ShopCategoriesSuccessState extends ShopAppStates{}
class ShopCategoriesErrorState extends ShopAppStates{
  final String error;

  ShopCategoriesErrorState(this.error);

}


class ShopFavoriteSuccessState extends ShopAppStates{}
class ShopFavoriteErrorState extends ShopAppStates{
  final String error;

  ShopFavoriteErrorState(this.error);

}


class ShopFavoriteChangeSuccessState extends ShopAppStates{
  final FavoriteChangeModel? model;

  ShopFavoriteChangeSuccessState(this.model);
}


class ShopGetFavoriteErrorState extends ShopAppStates{
  final String error;

  ShopGetFavoriteErrorState(this.error);

}
class ShopGetFavoriteChangeSuccessState extends ShopAppStates{
  final FavoritesModel? model;

  ShopGetFavoriteChangeSuccessState(this.model);
}
class ShopGetFavoriteChangeLoadingState extends ShopAppStates{}

class ShopUserErrorState extends ShopAppStates{
  final String error;

  ShopUserErrorState(this.error);

}
class ShopUserSuccessState extends ShopAppStates{
  final LoginModel? model;

  ShopUserSuccessState(this.model);
}
class ShopUserLoadingState extends ShopAppStates{}


class ShopRegisterLoadingState extends ShopAppStates{}
class ShopRegisterSuccessState extends ShopAppStates{
  final LoginModel model;

  ShopRegisterSuccessState(this.model);
}
class ShopRegisterErrorState extends ShopAppStates{
  final String error;

  ShopRegisterErrorState(this.error);

}


class ShopUpdateProfileLoadingState extends ShopAppStates{}
class ShopUpdateProfileSuccessState extends ShopAppStates{
  final LoginModel? model;

  ShopUpdateProfileSuccessState(this.model);
}
class ShopUpdateProfileErrorState extends ShopAppStates{
  final String error;

  ShopUpdateProfileErrorState(this.error);

}