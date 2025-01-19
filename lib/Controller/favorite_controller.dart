import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/main.dart';
import 'package:order_delievery/services/api.dart';

class FavoriteController extends GetxController {
  List<Product> favoriteList = [];
  Future<void> addToFavorite(int? productId) async {
    await Api().post(
        url: "$back_url/api/makeProductFavorite/"+lang,
        body: {"id": productId.toString()},
        token: userData?.getString('token'));
  }

  Future<void> removeFavorite(int? productId) async {
    await Api().post(
        url: "$back_url/api/makeProductUnFavorite/",
        body: {"id": productId.toString()},
        token: userData?.getString('token'));
  }

  Future<List<Product>?> getFavoriteProducts() async {
    try {
      List jsonData = await Api().get(
          url: "$back_url/api/getFavoriteList/$lang",
          token: userData?.getString('token'));

      for (var i = 0; i < jsonData.length; i++) {
        favoriteList.add(Product.fromJson1(jsonData, i));
      }

      return favoriteList;
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
