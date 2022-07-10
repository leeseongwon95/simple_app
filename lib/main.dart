import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home:MyApp(),
      )
  );
}


class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // statefulWidget 만들고 class 안에 변수만들면 됨
  var name = ['아줌마', '아저씨', '할머니'];
  var like = [0, 0, 0];
  var total = 3;

  addName(a){
    setState((){
      name.add(a);
    });
  }

  addOne(){
    setState((){
      total++;
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showDialog(context)
            // Scaffold.of(context)
            // Navigator.pop(context)
            // Theme.of(context)
            // context 가 강제됨
            // MaterialApp이 들어있는 context를 입력해야 잘 동작하는 함수임
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            showDialog(context: context, builder: (context) {
              return DialogUI(addOne : addOne, addName: addName,);
            });
          }
        ),
        appBar: AppBar( title: Text(total.toString()),),
        body: ListView.builder(
         itemCount: name.length,
         itemBuilder: (c, i){
           return ListTile(
             leading: Icon(Icons.account_circle_sharp),
             title: Text(name[i]),
             );
           },
        ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addName}) : super(key: key);
  final addOne;
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField( controller: inputData,),
            TextButton( child: Text('완료'), onPressed: (){
              addOne();
              addName(inputData.text);
            },),
            TextButton(
              child: Text('취소'),
              onPressed: (){
                Navigator.pop(context);
                },
            )
          ],
        ),
      ),
    );
  }
}
