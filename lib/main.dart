import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cachelper.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/screens/home.dart';
import 'package:shopapp/screens/login.dart';
import 'package:shopapp/screens/onboardscreen.dart';
import 'deffult.dart';
import 'dio/dio.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widet;
  bool? isDark=CacheHelper.getData(key: 'isDark');
  bool?onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');

  if(onBoarding!=null){
if(token!=null)widet =HomeScreen();
else{widet=LoginScreen();}
  }else{widet=OnBoardingScreen();}

  runApp(MyApp(
      isDark:isDark,
    StsrtWidet: widet,
  ));
}
class MyApp extends StatelessWidget {
  final  isDark;
   final  Widget StsrtWidet;
  // //
  MyApp({
     this.isDark,
     required this.StsrtWidet
   });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>ShopAppCubit()..getHomeData()..getcategoriesData()..getFavoriteData()..getUserData(),
     child: BlocConsumer<ShopAppCubit,ShopAppStates>(
       listener: (BuildContext context, state) {},
       builder: (BuildContext context, state) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             textTheme:  const TextTheme(
                 bodyText1: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                   color: Colors.black,

                 )
             ),
             primarySwatch: Colors.deepOrange,
             scaffoldBackgroundColor: Colors.white,
             appBarTheme:  const AppBarTheme(
               systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarColor: Colors.white,
                 statusBarIconBrightness: Brightness.dark,
               ),
               backgroundColor: Colors.white,
               elevation: 0.0,
               titleTextStyle: TextStyle(
                 color: Colors.black,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
               iconTheme: IconThemeData(
                 color: Colors.black,
               ),
             ),
           ),
           darkTheme: ThemeData(
             primarySwatch: Colors.deepOrange,
             scaffoldBackgroundColor: HexColor('#262626'),
             appBarTheme: AppBarTheme(
               systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarColor: HexColor('#262626'),
                 statusBarIconBrightness: Brightness.light,
               ),
               backgroundColor: HexColor('#262626'),
               elevation: 0.0,
               titleTextStyle: TextStyle(
                 color: Colors.grey[300],
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
               iconTheme: IconThemeData(
                 color: Colors.grey[300],
               ),
             ),
             bottomNavigationBarTheme: BottomNavigationBarThemeData(
                 backgroundColor: HexColor('262626'),
                 unselectedItemColor: Colors.grey[300],
                 elevation: 20
             ),
             textTheme: TextTheme(
                 bodyText1: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                   color: Colors.grey[300],

                 )
             ),
           ),

           home: StsrtWidet,
         );
       },
     ),
   );
  }
}
