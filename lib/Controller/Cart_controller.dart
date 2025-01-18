// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/main.dart';
import 'package:order_delievery/services/api.dart';

class CartController extends GetxController {
  int amount = 1;
  bool isloading = false;
  List<Product> cartList = [];
  List<Map<String, dynamic>> productOrderList = [];

  TextEditingController namecon = TextEditingController();
  TextEditingController cardcon = TextEditingController();
  TextEditingController locationcon = TextEditingController();
  GlobalKey<FormState> formKeyAll = GlobalKey();
  String? name = "";
  String? cardnumber = "";
  String? location = "";

  Future addToCart({
    required int productID,
  }) async {
    Map<String, String> headers = {};
    if (userData?.getString('token') != null) {
      headers.addAll({
        "Authorization": "Bearer ${userData?.getString('token')}",
        "Accept": "application/json"
      });
    } else {
      headers.addAll({"Accept": "application/json"});
    }
    try {
      http.Response response =
          await http.post(Uri.parse("$back_url/api/addToCart"),
              body: {
                "id": productID.toString(),
                "quantity": amount.toString(),
              },
              headers: headers);

      if (response.statusCode == 201) {
        return Get.snackbar('Successful', 'added to cart .',
            backgroundGradient:
                const LinearGradient(colors: [Colors.red, Colors.white]),
            snackPosition: SnackPosition.BOTTOM);
      }
      if (response.statusCode == 400) {
        return Get.snackbar('Error', 'Sorry.we do not have this quantity.',
            backgroundGradient:
                const LinearGradient(colors: [Colors.red, Colors.white]),
            snackPosition: SnackPosition.BOTTOM);
      }
      if (response.statusCode == 500) {
        throw " No Intrnet, Try again";
      } else {
        print(
            'There is problem ${response.body} and The statuscode is invalid : ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>?> getCartProducts() async {
    try {
      List jsonData = await Api().get(
          url: "$back_url/api/getCart", token: userData?.getString('token'));

      for (var i = 0; i < jsonData.length; i++) {
        cartList.add(Product.fromJson1(jsonData, i));
      }
      return cartList;
    } catch (e) {
      Get.snackbar('Error', 'No Internet. Please try again later.',
          backgroundGradient:
              const LinearGradient(colors: [Colors.red, Colors.white]),
          snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }

  Future<void> removeFromCart(dynamic productId) async {
    await Api().delete(
        url: "$back_url/api/removeFromCart?id=$productId",
        token: userData?.getString('token'));
  }

  Future addOrder() async {
    Map<String, String> headers = {};
    if (userData?.getString('token') != null) {
      headers.addAll({
        "Authorization": "Bearer ${userData?.getString('token')}",
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
    } else {
      headers.addAll({
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
    }

     try {
    // productOrderList.clear();
    // for (var i = 0; i < cartList.length; i++) {
    //   productOrderList.add({
    //     'id': cartList[i].id,
    //     'quantity': cartList[i].quantity,
    //   });
    // }
    // print(productOrderList);
    final body = {
      "name": namecon.text,
      "card_number": cardcon.text,
      "location": locationcon.text,
      "order_list": productOrderList
    };
    print('Request Body: ${jsonEncode(body)}');

    http.Response response = await http.post(
        Uri.parse("$back_url/api/addOrder"),
        body: jsonEncode(body),
        headers: headers);

    if (response.statusCode == 201) {
      return Get.snackbar('Ordered successfully', ' ',
          backgroundGradient:
              const LinearGradient(colors: [Colors.red, Colors.white]),
          snackPosition: SnackPosition.BOTTOM);
    }
    if (response.statusCode == 400) {
      return Get.snackbar('Error', '${response.body}',
          backgroundGradient:
              const LinearGradient(colors: [Colors.red, Colors.white]),
          snackPosition: SnackPosition.BOTTOM);
    }
    if (response.statusCode == 422) {
      return Get.snackbar('Error', '${response.body} ',
          backgroundGradient:
              const LinearGradient(colors: [Colors.red, Colors.white]),
          snackPosition: SnackPosition.BOTTOM);
    }
    if (response.statusCode == 500) {
      throw " No Intrnet, Try again";
    } else {
      print(
          'There is problem ${response.body} and The statuscode is invalid : ${response.statusCode}');
    }
    } catch (e) {
      rethrow;
    }
  }
}
