import 'package:flutter/material.dart';

import 'package:formvalidation/bloc/provider.dart';
import 'package:formvalidation/models/producto_model.dart';
import 'package:formvalidation/providers/productos_provider.dart';



class HomePage extends StatelessWidget {


     final productosProvider= new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    
   /*  productosProvider.cargarProductos(); */

    //final bloc=Provider.of(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase - Provider - Bloc')
      ),
      body: _crearListado(),
      
      
      /* Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _crearListado()
            ],
          ),
        ), */

      floatingActionButton: _creatBoton(context),
    );
  }

    Widget _crearListado(){
                
         return FutureBuilder(
          future:productosProvider.cargarProductos(),
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
            if(snapshot.hasData){
              
                final productos = snapshot.data;

                return ListView.builder(
                  itemCount: productos.length,
                  itemBuilder:(context,i) => _crearItem(productos[i],context),
                  
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

    Widget _crearItem(ProductoModel producto,BuildContext context){

      return Dismissible(
        key : UniqueKey(),
        background: Container(
            color: Colors.red,
        ),
        onDismissed: (direccion){
          //borrar producto
          
          productosProvider.borrarProducto(producto.id);
          productosProvider.cargarProductos();
          
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
                        productosProvider.cargarProductos(); 
                        },
              ),
            ],
          ),
        ),
      );

       
    }

    _creatBoton(BuildContext context){
     return FloatingActionButton(
       child: Icon(Icons.add),
       backgroundColor: Colors.deepOrange,
       onPressed: () {
         Navigator.pushNamed(context,'producto');
         productosProvider.cargarProductos();
       },
     );

  }
   


   
}