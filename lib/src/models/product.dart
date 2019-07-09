
import 'dart:convert';

import 'package:http/http.dart' as http;

class Product{
  int id;
  String name;
  int price;
  int price_old;
  String picture;
  int instock;
  Product({this.id, this.name, this.price,this.price_old, this.picture, this.instock});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        price_old: json["price_old"],
        picture: json["picture"],
        instock: json["onHand"]);
  }

}

Future<List<Product>> fetchProducts(http.Client client) async {
  final response =
      await client.get("https://vinasave.lychanhdaric.com/api/products");
  if (response.statusCode == 200) {
    final mapResponse = json.decode(response.body); 
      final lisOfproducts = await mapResponse.map<Product>((json) {
        return Product.fromJson(json);
      }).toList(); 
      return lisOfproducts; 
  }
   else {
      throw Exception('Mất mạng!');
    }
}
Future<List<Product>> fetchThanhLyProducts(http.Client client) async {
  final response =
      await client.get("https://vinasave.lychanhdaric.com/api/thanhlyproducts");
  if (response.statusCode == 200) {
    final mapResponse = json.decode(response.body); 
      final lisOfproducts = await mapResponse.map<Product>((json) {
        return Product.fromJson(json);
      }).toList(); 
      return lisOfproducts; 
  }
   else {
      throw Exception('Mất mạng!');
    }
}

Future<Product> fetchProduct(http.Client client, int productId) async {
  final response =
      await client.get("https://vinasave.lychanhdaric.com/api/products/$productId");
       print(productId);
  if (response.statusCode == 200) {
    final mapResponse = json.decode(response.body);
    print(mapResponse);
    return Product.fromJson(mapResponse);
       
  }
   else {
      throw Exception('Mất mạng!');
    }
}
