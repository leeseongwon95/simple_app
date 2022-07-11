import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status; // await : 오래걸리는 줄은 제껴두고 다음 줄 실행하려고 함
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      // print(contacts[0].givenName); // 이름가져오기
      // var newPerson = Contact();
      // newPerson.givenName = 'minhee';
      // newPerson.familyName = 'choi';
      // await ContactsService.addContact(newPerson);
      setState((){
        name = contacts;
      });

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); // 허락해달라고 팝업띄우는 코드
      // openAppSettings(); // 거절 2번 당하면 다신 뜨지 않음(정책상) ㄷ ㄷ
      // 그래서 거절당하면 유저가 앱설정 지가 직접 들어가서 권한 켜야함 그때 openAppSetting ㄱㄱ 하면될듯
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // initState 안에 적은 코드는 위젯 로드될 때 한번 실행됨
  //   getPermission();
  // }

  // statefulWidget 만들고 class 안에 변수만들면 됨
  var name = [];
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
        appBar: AppBar( title: Text(total.toString()), actions: [
          IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
        ],),
        body: ListView.builder(
         itemCount: name.length,
         itemBuilder: (c, i){
           return ListTile(
             leading: Icon(Icons.account_circle_sharp),
             title: Text(name[i].givenName),
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
              var newContact = Contact();
              newContact.givenName = inputData.text; // 새로운 연락처 만들고
              ContactsService.addContact(newContact); // 실제로 연락처에 집어넣기
              addName(newContact); // name이라는 state에도 그냥 저장해줌 확인용
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
