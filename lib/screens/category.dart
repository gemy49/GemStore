import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/deffult.dart';
import 'package:shopapp/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context,ShopAppStates state){},
      builder: (BuildContext context,ShopAppStates state){
        var cubit =ShopAppCubit.get(context);
        return BuildCondition(
          condition: cubit.categoriesModel!=null,
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=> categories(cubit.categoriesModel!.data!.data[index],context),
              separatorBuilder:(context,index)=> divider(),
              itemCount: cubit.categoriesModel!.data!.data.length
          ),
        );
    },
    );
  }
  Widget categories(CategoriesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
         Image(
            image: NetworkImage('${model.image}'),
            width: 100,
            height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 20,),
         Text('${model.name}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: (){
            },
            icon:const Icon( Icons.arrow_forward_ios),
        )
      ],
    ),
  );
}
