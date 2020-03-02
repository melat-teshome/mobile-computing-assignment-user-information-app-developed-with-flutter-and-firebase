import 'package:flutter/material.dart';
import 'login.dart';
int main(){

  runApp(new MyApp());

}

class MyApp extends StatelessWidget{


    @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      theme: new ThemeData(
     backgroundColor: Colors.deepPurple[200],
      primaryColor: Colors.deepPurple[300],
      ),
      home: new LoginPage()
    );
  }

}

