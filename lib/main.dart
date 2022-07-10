import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity, height: 50,
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(color: Colors.pink),
              borderRadius: BorderRadius.all(Radius.circular(23))
            ),
          ),
        )
      )
    );
}
}