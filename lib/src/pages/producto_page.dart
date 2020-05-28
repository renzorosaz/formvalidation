import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/bloc/productos_bloc.dart';
import 'package:formvalidation/bloc/provider.dart';
import 'package:formvalidation/models/producto_model.dart';
import 'package:formvalidation/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey =GlobalKey<FormState>();
  final scafooldKey =GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();

  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

     productosBloc = Provider.productosBloc(context); 
    final ProductoModel produdData = ModalRoute.of(context).settings.arguments;
    
    if(produdData != null){
    producto = produdData;
  }


    return Scaffold(
      key: scafooldKey,
      appBar: AppBar(
        title:Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
            ),
            IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
           
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){

    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value)=> producto.titulo =value,
      validator: (value){
          if(value.length <3){
            return 'Ingrese el nombre del producto';
          }else{
            return null;
          }
      },
    );

  }

  Widget _crearDisponible(){

    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.orangeAccent,
     onChanged: (value) =>setState((){
       producto.disponible =value;
     }) ,
    );
  }

  Widget _crearPrecio(){

     return TextFormField(
       initialValue: producto.valor.toString(),
       keyboardType: TextInputType.numberWithOptions(decimal:true),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value)=> producto.valor =double.parse(value),
      validator: (value){
         if(utils.isNumerico(value)){
           return null;
         }
         else{
           return 'Sólo numero';
         }
      },
    );
  }

   Widget  _crearBoton(){
     
        return RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
            color: Colors.purpleAccent,
            textColor: Colors.white,
            icon: Icon(Icons.save),
            label: Text('Guardar'),
            onPressed:(  _guardando) ? null : _submit,
        );  
  }

  void _submit() async{


      if(!formKey.currentState.validate()) return;
      
      formKey.currentState.save();

      

      if(foto != null){
        
        producto.fotoUrl = await productosBloc.subirFoto(foto);
      }


      setState(() { _guardando =true;  });

      if(producto.id ==null){
        productosBloc.agregarProducto(producto);
      }else{
        productosBloc.editarProducto(producto);
      }
      

    mostrarSnackbar('Registro Guardado');
    
    Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }

  void mostrarSnackbar(String mensaje){

    final snackbar= SnackBar(

      content: Text(mensaje),
      duration: Duration(milliseconds:1500),
      backgroundColor: Colors.orangeAccent,
    );

    scafooldKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto(){
          if (producto.fotoUrl != null) {
      
            return FadeInImage(
              image: NetworkImage(producto.fotoUrl),
              placeholder: AssetImage('carga.gif'),
              height: 150.0,
              fit: BoxFit.contain,
            );
      
          } else {
      
            if( foto != null ){
              return Image.file(
                foto,
                fit: BoxFit.cover,
                height: 150.0,
              );
            }
            return Image.asset('assets/original.png');
          }
  }

  _seleccionarFoto() async{
    
   _procesarImagen(ImageSource.gallery);

  }

  _tomarFoto() async {

    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async{

       foto = await ImagePicker.pickImage(
       source: origen
        );

      if(foto != null){
          producto.fotoUrl = null;
     }

   setState(() {});
   
  }
}