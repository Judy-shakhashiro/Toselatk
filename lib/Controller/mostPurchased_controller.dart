import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/main.dart';
import 'package:order_delievery/services/api.dart';

class MostPurchasedController extends GetxController {
  Future<List<Product>> getMostPurchased() async {
    List<Product> mostPurchasedList = [];

    try {
      List jsonData = await Api().get(
          url: "$back_url/api/getBestseller/$lang",
          token: userData?.getString('token'));

      for (var i = 0; i < jsonData.length; i++) {
        mostPurchasedList.add(Product.fromJson1(jsonData, i));
      }
      return mostPurchasedList;
    } catch (e) {
      Get.snackbar(
        'Error',
        'No Internet. Please try again later.',
        backgroundGradient: LinearGradient(colors: [Colors.red,Colors.white]),snackPosition: SnackPosition.BOTTOM
      );
      return [];
    }
  }
}
