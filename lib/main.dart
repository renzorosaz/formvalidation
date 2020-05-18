import 'package:flutter/material.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';

import 'bloc/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute:'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    ),

    );
    
    
    
  }
}