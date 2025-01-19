import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:order_delievery/Controller/Cart_controller.dart';
import 'package:order_delievery/Controller/Order_controller.dart';
import 'package:order_delievery/Model/order.dart';
import 'package:order_delievery/View/Widegt/most_purchased.dart';
import 'package:order_delievery/View/Widegt/order_widegt.dart';
import 'package:order_delievery/View/products_order.dart';
import 'package:order_delievery/constans.dart';
import 'package:shimmer/shimmer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderController controller = Get.put(OrderController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constans.screen,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 80),
            child: Text("MY ORDER",
                style: TextStyle(
                  fontFamily: Constans.fontFamily,
                  fontSize: 22,
                )),
          ),
          backgroundColor: Constans.screen,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: GetBuilder<OrderController>(builder: (controller) {
          return FutureBuilder<List<Order>?>(
              future: OrderController().getOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return getShimmerOrders();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return getShimmerOrders();
                } else if (snapshot.hasData) {
                  List<Order> orderList = snapshot.data!;
                  return orderList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                return OrderWidget(
                                  onTap: () {
                                    Get.to(ProductsOrder(
                                        products: orderList[index].products));
                                  },
                                  order: orderList[index],
                                  onPressed: () async {
                                    await controller
                                        .removeFromOrder(orderList[index].id);
                                    controller.update();
                                  },
                                );
                              }),
                        )
                      : Container(
                          padding: const EdgeInsets.only(top: 230, left: 25),
                          child: SizedBox(
                              height: 200,
                              width: 2000,
                              child: Image.asset(
                                "assets/images/no-order.png",
                              )),
                          // child: const Text(
                          //   "Your cart list is empty",
                          //   style: TextStyle(
                          //       fontSize: 25,
                          //       fontFamily: Constans.fontFamily,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        );
                  // : Container(
                  //     padding: const EdgeInsets.only(top: 300, left: 35),
                  //     child: const Text(
                  //       "Your orders list is empty",
                  //       style: TextStyle(
                  //           fontSize: 25,
                  //           fontFamily: Constans.fontFamily,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   );
                } else {
                  return getShimmerOrders();
                }
              });
        }));
  }

  Shimmer getShimmerOrders() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,

                width: MediaQuery.of(context).size.width * 0.9,
                // color: Colors.grey[400]!,
                decoration: ShapeDecoration(
                    color: Colors.grey[300]!,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(17)))),
              );
            },
          ),
        ));
  }
}
