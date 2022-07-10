import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 1; // statefulWidget 만들고 class 안에 변수만들면 됨
  var name = ['아줌마', '아저씨', '할머니'];
  var like = [0, 0, 0];
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(a.toString()),
          onPressed: (){
            setState((){
              a++;
            });
          },
        ),
        appBar: AppBar( title: Text('연락처앱'),),
        body: ListView.builder(
         itemCount: 3,
         itemBuilder: (c, i){
           print(i);
           return ListTile(
             title: Text(name[i]),
             leading: Text(like[i].toString()),
             trailing:ElevatedButton(
               child: Text('좋아요'),
               onPressed: (){
                 setState((){
                   like[i]++;
                 });
             },),

             );
           },
       ),
      ),
    );
  }
}
