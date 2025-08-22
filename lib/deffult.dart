import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void navigateToAndDelete({
  required screen,
  required context,
})=>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(
      builder: (context)=>screen,), (route) => false
    );
void navigateTo({
  required context,
  required screen
}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => screen,
  ),
);
Widget buildTaskItem(article,context) => InkWell(
  onTap: (){
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(article['url'])));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child:   Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image:DecorationImage(image:article['urlToImage']==null?NetworkImage('https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg'):

            NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    maxLines: 3,

                    overflow: TextOverflow.clip,

                    style: Theme.of(context).textTheme.bodyText1,



                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      fontWeight: FontWeight.w600,

                      fontSize: 15,

                      color: Colors.grey

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
Widget divider()=>Container(
  width: double.infinity,
  height: 2.0,
  color: Colors.grey[300],
);
Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  var onTap,
  var onChange,
  var  type,
  var suffix,
  var function ,
  var validator,
  bool isPassword = false ,
}
    ) =>
    TextFormField(
      onChanged: onChange,
      validator: validator,
      onTap: onTap,
      obscureText:isPassword ,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: function,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );