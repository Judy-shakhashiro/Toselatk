import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/Model/order.dart';
import 'package:order_delievery/main.dart';
import 'package:order_delievery/services/api.dart';

class OrderController extends GetxController {
  List<Order> orderList = [];

  Future<List<Order>?> getOrders() async {
    try {
    List jsonData = await Api().get(
        url: "$back_url/api/getUserOrders/$lang",
        token: userData?.getString('token'));

    for (var i = 0; i < jsonData.length; i++) {
      orderList.add(Order.fromJson(jsonData, i));
    }

    return orderList;
    } catch (e) {
      Get.snackbar('Error', 'No Internet. Please try again later.',
          backgroundGradient:
              const LinearGradient(colors: [Colors.red, Colors.white]),
          snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }

  Future<void> removeFromOrder(dynamic orderId) async {
    await Api().delete(
        url: "$back_url/api/deleteOrder?order_id=$orderId",
        token: userData?.getString('token'));
  }
}
