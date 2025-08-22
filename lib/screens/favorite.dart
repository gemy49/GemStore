import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/deffult.dart';
import 'package:shopapp/models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context,ShopAppStates state) {
      if(ShopAppCubit.get(context).favoriteChangeModel!=null)  {
          if (state is ShopFavoriteChangeSuccessState) {
            if (!state.model!.status!) {
              FlutterToastr.show(
                '${state.model!.message}',
                context,
                duration: FlutterToastr.lengthLong,
                position: FlutterToastr.bottom,
                backgroundColor: Colors.red,
              );
            }
          }
        }
      },
      builder: (BuildContext context, ShopAppStates state) {
        var cubit = ShopAppCubit.get(context);
        return BuildCondition(
          condition:cubit.favoriteModel!=null,
          fallback:(context)=>  Center(child: CircularProgressIndicator()),
          builder: (context)=> ListView.separated(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=> favorites(cubit.favoriteModel!.data!.data[index],context),
            separatorBuilder:  (context,index)=>divider(),
            itemCount: cubit.favoriteModel!.data!.data.length,
          ),
          );
      },
    );
  }
  Widget favorites(FavoritesData model,context)=> SizedBox(
    height: 120,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
          children: [
            Stack(
                alignment:AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model.product!.image}',),
                    width: 120,
                    height: 120,
                  ),
                  if('${model.product!.discount}'!=0)
                    Container(
                      color: Colors.red,
                      child:const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ) ,
                    )  ,
                ]
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Text('${model.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text('${model.product!.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.orangeAccent,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 15,),
                      if('${model.product!.discount}'!=0)
                        Text('${model.product!.oldPrice}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                       backgroundColor: ShopAppCubit.get(context).favorites[model.product!.id]!?Colors.blue[300]:Colors.grey[300],
                        child: IconButton(
                          onPressed: (){
                            ShopAppCubit.get(context).postFavoriteData(model.product!.id!);
                          },
                          icon: const Icon(Icons.favorite_border),color: Colors.white,),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]
      ),
    ),
  );
}
