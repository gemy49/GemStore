import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/cachelper.dart';
import 'package:shopapp/deffult.dart';
import 'package:shopapp/screens/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boarding{
  final String image;
  final String title;
  final String body;
  Boarding({ required this.title,
    required this.image,
   required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var builderController= PageController();
bool isLast=false;
void submit(){
  CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
    navigateToAndDelete(context: context, screen: LoginScreen());
  }).catchError((error){print("error is ${error}");});

}
  List<Boarding>boardingItem=[
Boarding(
    title:'onBoardingScreen1',
    image:'assets/shoping.jpg',
    body:'onBoardingBody1',
),
Boarding(
    title:'onBoardingScreen2',
    image:'assets/shoping2.jpg',
    body:'onBoardingBody2',
),
Boarding(
    title:'onBoardingScreen3',
    image:'assets/shoping3.jpg',
    body:'onBoardingBody3',
),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: const Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
           Expanded(
             child: PageView.builder(
                 itemBuilder: (context,index)=>itemBuilderPage(boardingItem[index]),
               onPageChanged: (int index){
                   if(index==boardingItem.length-1){
                     setState(() {
                       isLast=true;
                     });
                   }
                   else{
                     setState(() {
                       isLast=false;
                     });
                   }
               },
               itemCount: boardingItem.length,
               controller: builderController,
               physics: const BouncingScrollPhysics(),
             ),
           ),
            Row(
              children: [
               SmoothPageIndicator(
                   controller: builderController,
                   count: boardingItem.length,
                 effect: const ExpandingDotsEffect(
                   dotColor: Colors.grey,
                   expansionFactor: 2,
                   activeDotColor: Colors.deepOrange,
                 ),
               ),

                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                    onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      builderController.nextPage(
                          duration: const Duration(milliseconds: 750 ),
                          curve: Curves.fastOutSlowIn
                      );
                    }
                    }
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuilderPage(Boarding model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children:  [
      Expanded(
        child: Image(image: AssetImage(model.image),
        fit: BoxFit.fill,),
      ),
      const SizedBox(height: 50,),
      Text(model.title,
        style: const TextStyle(
            fontSize: 25,
               fontWeight: FontWeight.w900
        ),
      ),
      const SizedBox(height: 50,),
      Text(model.body,
      style: const TextStyle(
        fontSize: 16,
      ),
      ),
    ],
  );
}
