import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/deffult.dart';
import 'package:shopapp/screens/search.dart';

import '../cubit/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context,ShopAppStates state) {},
      builder: (BuildContext context, ShopAppStates state) {
        var cubit=ShopAppCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text('home'),
          actions: [
            IconButton(
                onPressed: (){
                  navigateTo(screen: SearchScreen(), context: context);
                },
                icon: Icon(Icons.search),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: cubit.currentIndex,
          backgroundColor: Colors.white,
          onTap: (index) {
            cubit.BottomNave(index);
          },
          items:const [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'category'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
          ],
        ),
          body: cubit.screens[cubit.currentIndex],
      );
        },
    );
  }
}
