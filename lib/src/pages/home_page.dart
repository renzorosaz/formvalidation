import 'package:flutter/material.dart';
import 'package:formvalidation/bloc/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final bloc=Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Casita'),
      ),
      body : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            Divider(),
            Text('Password: ${bloc.password}'),
            
          ],
        ),
    );
  }
}