import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:order_delievery/main.dart';
import 'dart:async';
import 'package:order_delievery/shops.dart';
// A function that converts a response body into a List<Photo>.
class Store {
  final String name;
  final int id;
  final String description;
  final String url;
  final String location;


  const Store({
    required this.name,
    required this.id,
    required this.description,
    required this.url,
    required this.location,

  });

  factory Store.fromJson(Map<String, dynamic> json) {

    return Store(
      name: json['name'] as String,
      id: json['id'] as int,
      description: json['description'] as String,
      url: back_url+json['picture'] as String,
      location: json['location'] as String,

    );
  }
}
class Product {
  final String name;
  final int store_id;
  final int id;
  final String description;
  final int price;
  final String picture;
  final String? store_name;
  final bool? favourite;

  const Product({
    required this.name,
    required this.store_id,
    required this.id,
    required this.description,
    required this.price,
    required this.picture,
     this.store_name,
     this.favourite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    return Product(
      name: json['name'] as String,
      store_id: json['store_id'] as int,
      id: json['id'] as int,
      description: json['description'] as String,
      price: json['price'] as int,
      picture: back_url+json['picture'] as String,
      store_name: json['store_name'] as  String,
      favourite: json['favourite'] as bool,

    );
  }
}
class StoresAndProduct{
 static List<Store> parseStores(String responseBody) {
    final parsed =
    (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

    return parsed.map<Store>((json) => Store.fromJson(json)).toList();
  }
 static List<Product>? parseProducts(String? responseBody) {
   if(responseBody!=null) {
      final parsed =
          (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

      return parsed.map<Product>((json) => Product.fromJson(json)).toList();
    }
   return null;
  }
static Future<String?> fetchStoresJson(String id) async {
  try{
    var token =userData?.getString('token');
    var response= await http.post(Uri.parse(back_url+"/api/getStoresByCategory/+$lang"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String,String>{
          "category_id" : id,
        })
    );
    if (response.statusCode == 200) {
      print('fetched successsfully: ${['message']}');
      return  response.body;
    } else if (response.statusCode == 401) {
      final data = jsonDecode(response.body);
      print('Error: ${data['message']}');
    } else {
      final data = jsonDecode(response.body);
      print('Unexpected error: ${response.statusCode}');
      print('message: ${data['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;

}
 static Future<String?> fetchProductsJson(String id) async {
   try{
     var token =userData?.getString('token');
     var response= await http.post(Uri.parse(back_url+"/api/getProductsByStore/+$lang"),
         headers: <String,String>{
           'Content-Type': 'application/json; charset=UTF-8',
           'Authorization': 'Bearer $token',
         },
         body: jsonEncode(<String,String>{
           "store_id" : id,
         })
     );
     if (response.statusCode == 200) {
       print('fetched successsfully: ${['message']}');

       return  response.body;

     } else if (response.statusCode == 401) {
       final data = jsonDecode(response.body);
       print('Error: ${data['message']}');
     } else {
       final data = jsonDecode(response.body);
       print('Unexpected error: ${response.statusCode}');
       print('message: ${data['message']}');
     }
   } catch (e) {
     print('Error: $e');
   }
   return null;

 }
 static Future<String?> fetchSearchProductsJson(String searchWord) async {
   try{
     var token =userData?.getString('token');
     var response= await http.post(Uri.parse(back_url+"/api/searchProducts+$lang"),
         headers: <String,String>{
           'Content-Type': 'application/json; charset=UTF-8',
           'Authorization': 'Bearer $token',
         },
         body: jsonEncode(<String,String>{
           "name" : searchWord,
         })
     );
     if (response.statusCode == 200) {
       print('fetched successsfully: ${['message']}');

       return  response.body;

     } else if (response.statusCode == 401) {
       final data = jsonDecode(response.body);
       print('Error: ${data['message']}');
     } else {
       final data = jsonDecode(response.body);
       print('Unexpected error: ${response.statusCode}');
       print('message: ${data['message']}');
     }
   } catch (e) {
     print('Error: $e');
   }
   return null;

 }
 static Future<String?> fetchSearchStoresJson(String searchWord) async {
   try{
     var token =userData?.getString('token');
     var response= await http.post(Uri.parse(back_url+"/api/searchStores/+$lang"),
         headers: <String,String>{
           'Content-Type': 'application/json; charset=UTF-8',
           'Authorization': 'Bearer $token',
         },
         body: jsonEncode(<String,String>{
           "name" : searchWord,
         })
     );
     if (response.statusCode == 200) {
       print('fetched successsfully: ${['message']}');
       return  response.body;
     } else if (response.statusCode == 401) {
       final data = jsonDecode(response.body);
       print('Error: ${data['message']}');
     } else {
       final data = jsonDecode(response.body);
       print('Unexpected error: ${response.statusCode}');
       print('message: ${data['message']}');
     }
   } catch (e) {
     print('Error: $e');
   }
   return null;

 }
 static Future<List<Product>?>productsByStore(String id) async {
   var products=await fetchProductsJson(id);
   return parseProducts(products!);
 }
 static Future<List<Product>?>searchProducts(String searchWord) async {
   var products=await fetchSearchProductsJson(searchWord);
   return parseProducts(products);
 }

  static Future<List<Store>>storesByType(String id) async {
    var stores=await fetchStoresJson(id);
    return parseStores(stores!);
    }

 static Future<List<Store>>searchStores(String searchWord) async {
   var stores=await fetchSearchStoresJson(searchWord);
   return parseStores(stores!);
 }

}