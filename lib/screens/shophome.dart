import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:shopapp/cubit/bloc.dart';
import 'package:shopapp/cubit/cubit.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context, state) {
        if(ShopAppCubit.get(context).favoriteChangeModel!=null){
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
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppCubit.get(context);
        return
           BuildCondition(
              condition: cubit.homeModel!=null&&cubit.categoriesModel!=null,
              builder: (context) => Screen(cubit.homeModel!,cubit.categoriesModel!,context),
              fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget Screen(HomeModel model,CategoriesModel categoriesmodel,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval:Duration(seconds: 3,),
                autoPlayAnimationDuration: Duration(seconds: 1,),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
              items: model.data!.banners!.map((e) => Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              )).toList()
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  const Text('categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10,),
               Container(
                 height: 120,
                 child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context,index)=> categories(categoriesmodel.data!.data[index]),
                     separatorBuilder:  (context,index)=>const SizedBox(width: 10,),
                     itemCount: categoriesmodel.data!.data.length,
                 ),
               ),
                  const SizedBox(height: 20,),
                  const Text('products',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1/1.602,
                mainAxisSpacing: 2,
                children:
                  List.generate(model.data!.products!.length,
                        (index) => products(model.data!.products![index],context),
                  )


              ),
            )
          ],
        ),
      ),
    ),
  );
  Widget products(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment:AlignmentDirectional.bottomStart,
         children: [
           Image(
             image: NetworkImage('${model.image}',),
             width: double.infinity,
             height: 200,
           ),
           if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Text('${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                ),
    ),
              Row(
                children: [
                  Text('${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.orangeAccent,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  if(model.discount!=0)
                    Text('${model.old_price.round()}',
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
                    backgroundColor: ShopAppCubit.get(context).favorites[model.id!]!?Colors.blue[300]:Colors.grey[300],
                    child: IconButton(
                        onPressed: (){
                          ShopAppCubit.get(context).postFavoriteData(model.id!);
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
  );
  Widget categories(CategoriesData model)=>Stack(
    alignment: Alignment.bottomCenter,
    children:  [
       Image(
        image: NetworkImage('${model.image}'),
        width: 120,
        height: 120,
      ),
      Container(
        width: 120,
        color: Colors.black.withOpacity(.6),
        child:  Text('${model.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),

    ],
  );
}
