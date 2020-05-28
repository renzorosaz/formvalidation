import 'package:flutter/material.dart';

import 'package:formvalidation/src/pages/home_page.dart';
import 'package:formvalidation/src/pages/login_page.dart';
import 'package:formvalidation/src/pages/producto_page.dart';
import 'package:formvalidation/src/pages/registro_page.dart';
import 'package:formvalidation/src/preferencas_usuario/preferencias_usuarios.dart';

import 'bloc/provider.dart';
 
void main() async {
  
    WidgetsFlutterBinding.ensureInitialized();
    final prefs= new PreferenciasUsuario();
    await prefs.initPrefs();

runApp(MyApp());

}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
        final pres= new PreferenciasUsuario();
      print(pres.token);
      
    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute:'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'registro' : (BuildContext context) => RegistroPage(),
        'home' : (BuildContext context) => HomePage(),
        'producto' : (BuildContext context) => ProductoPage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
    ),

    );
    
    
    
  }
}