import 'package:flutter/material.dart';

bool isNumerico(String s){

  if (s.isEmpty) return false;

  final n= num.tryParse(s);
  
  return (n==null) ? false : true;

}


void mostrarAlerta(BuildContext context, String mensaje){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Información Incorrecta"),
          content: Text(mensaje),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}