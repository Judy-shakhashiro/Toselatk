import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/Controller/Cart_controller.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/View/Widegt/cart_widget.dart';
import 'package:order_delievery/View/payment_page.dart';
import 'package:order_delievery/constans.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartController controller = Get.put(CartController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        title:  Padding(
          padding: EdgeInsets.only(left: 160),
          child: Text("33".tr,
              style: TextStyle(
                fontFamily: Constans.fontFamily,
                fontSize: 22,
              )),
        ),
        backgroundColor: Constans.screen,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.64,
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<CartController>(builder: (controller) {
                return FutureBuilder<List<Product>?>(
                    future: CartController().getCartProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return getShimmerCart();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == null) {
                        return getShimmerCart();
                      } else if (snapshot.hasData) {
                        List<Product> cartList = snapshot.data!;
                        controller.cartList = snapshot.data!;
                        controller.productOrderList.clear();
                        for (var i = 0; i < cartList.length; i++) {
                          controller.productOrderList.add({
                            'id': cartList[i].id,
                            'quantity': cartList[i].quantity,
                          });
                        }
                        return cartList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: cartList.length,
                                itemBuilder: (context, index) {
                                  return CartWidget(
                                    product: cartList[index],
                                    onPressed: () async {
                                      await controller
                                          .removeFromCart(cartList[index].id);
                                      controller.update();
                                    },
                                    widget: Text(
                                    " ${"35".tr} : ${cartList[index].quantity.toString()}",
                                      style: const TextStyle(
                                          fontFamily: Constans.fontFamily,
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // widget: GetBuilder<CartController>(
                                    //     builder: (controller) {
                                    //   return Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.center,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               cartList[index].quantity =
                                    //                   cartList[index]
                                    //                           .quantity! +
                                    //                       1;
                                    //             });
                                    //           },
                                    //           child: const Icon(
                                    //             Icons.add,
                                    //             color: Colors.black,
                                    //             size: 18,
                                    //           )),
                                    //       Text(
                                    //         cartList[index]
                                    //             .quantity.toString()
                                    //             ,
                                    //         style: const TextStyle(
                                    //             fontFamily:
                                    //                 Constans.fontFamily,
                                    //             fontSize: 18,
                                    //             color: Colors.black,
                                    //             fontWeight: FontWeight.w500),
                                    //       ),
                                    //       InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //               if (
                                    //                       cartList[index]
                                    //                           .quantity! >
                                    //                   1) {
                                    //                 cartList[index].quantity =
                                    //                     cartList[index]
                                    //                             .quantity! -
                                    //                         1;
                                    //               }
                                    //             });
                                    //           },
                                    //           child: const Icon(
                                    //             Icons.remove,
                                    //             color: Colors.black,
                                    //             size: 18,
                                    //           )),
                                    //     ],
                                    //   );
                                    // })
                                  );
                                })
                            : Container(
                                padding:
                                    const EdgeInsets.only(top: 300, left: 25),
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      "assets/images/empty-cart.png",
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
                      } else {
                        return getShimmerCart();
                      }
                    });
              })),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(33), topLeft: Radius.circular(33)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  const Padding(
                //   padding: EdgeInsets.only(top: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //      const Text("Total Price:",
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black,
                //             fontFamily: Constans.fontFamily,
                //             fontSize: 25,
                //           )),
                //       Text(
                //        "55",
                //           style: const TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black,
                //             fontFamily: Constans.fontFamily,
                //             fontSize: 22,
                //           )),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(PaymentPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constans.appColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child:  Text(
                          "34".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: Constans.fontFamily,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Shimmer getShimmerCart() {
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
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.height * 0.15,
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
