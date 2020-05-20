import 'package:flutter/material.dart';
import 'package:formvalidation/models/producto_model.dart';
import 'package:formvalidation/providers/productos_provider.dart';
import 'package:formvalidation/utils/utils.dart';


class ProductoPage extends StatefulWidget {
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey =GlobalKey<FormState>();

  final productoProvider= new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed:(){}
            ),
            IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed:(){}
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
         if(isNumerico(value)){
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
            color: Colors.deepOrange,
            textColor: Colors.white,
            icon: Icon(Icons.save),
            label: Text('Guardar'),
            onPressed: _submit,
        );  
  }

  void _submit(){

      if(!formKey.currentState.validate()) return;
      
      formKey.currentState.save();

      print('todo ok');
      print(producto.titulo);
      print(producto.valor);
      print(producto.disponible);

productoProvider.crearProducto(producto);

  }
}