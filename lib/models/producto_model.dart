import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

/* class Productos{

  List <ProductoModel> items= new List();

  Productos();

  Productos.fromJsonList(List<dynamic> jsonList){

    if(jsonList==null) return;

    for(var item in jsonList){

      final producto = new ProductoModel.fromJson(item);
      items.add(producto);

    }
  }
  
} */
class ProductoModel {
    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor = 0.0 ,
        this.disponible = true,
        this.fotoUrl,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id:       json["id"],
        valor:      json["valor"],
        titulo:      json["titulo"],
        disponible:      json["disponible"],
        fotoUrl:      json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
       //"id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
    
getPosterImg(){

    if(fotoUrl==null){
      return 'https://staticuestudio.blob.core.windows.net/buhomag/2017/03/09175635/misterios-sin-resolver.jpg';

    }else{

     return 'https://image.tmdb.org/t/p/w500/$fotoUrl';
    }

  }


}
