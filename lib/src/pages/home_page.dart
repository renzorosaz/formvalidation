import 'package:flutter/material.dart';
import 'package:formvalidation/bloc/productos_bloc.dart';

import 'package:formvalidation/bloc/provider.dart';
import 'package:formvalidation/models/producto_model.dart';
import 'package:formvalidation/providers/productos_provider.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
   final productosBloc = Provider.productosBloc(context);
   productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase - Provider - Bloc')
      ),
      body: _crearListado(productosBloc),
      
      
      /* Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _crearListado()
            ],
          ),
        ), */

      floatingActionButton: _creatBoton(context,productosBloc),
    );
  }

    Widget _crearListado(ProductosBloc productosBloc){

        return StreamBuilder(
          stream: productosBloc.productosStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
            if(snapshot.hasData){
              
                final productos = snapshot.data;

                return ListView.builder(
                  itemCount: productos.length,
                  itemBuilder:(context,i) => _crearItem(productos[i],productosBloc,context),
                  
                );
                
            }
            else{
              return Center(
                  child: CircularProgressIndicator(),
              );
            }
          },
        );

    }

    Widget _crearItem(ProductoModel producto,ProductosBloc productosBloc,BuildContext context){

      return Dismissible(
        key : UniqueKey(),
        background: Container(
            color: Colors.red,
        ),
        onDismissed: (direccion){
          //borrar producto    
          productosBloc.cargarProductos();   
          productosBloc.borrarProducto(producto.id);
          
        },
        child: Card(
          child: Column(
            children: <Widget>[

              (producto.fotoUrl == null)
                ?Image(image:AssetImage('assets/original.png'))
                : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/carga.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                ),

                   ListTile(
                        title: Text('${producto.titulo} - ${producto.valor}'),
                        subtitle:Text(producto.id),
                        onTap:() {
                          Navigator.pushNamed(context, 'producto', arguments: producto);
                        productosBloc.cargarProductos(); 
                        },
              ),
            ],
          ),
        ),
      );

       
    }

    _creatBoton(BuildContext context,ProductosBloc productosBloc){
     return FloatingActionButton(
       child: Icon(Icons.add),
       backgroundColor: Colors.deepOrange,
       onPressed: () {
         Navigator.pushNamed(context,'producto');
         productosBloc.cargarProductos();
       },
     );

  }
   


   
}