import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:order_delievery/Controller/Cart_controller.dart';
import 'package:order_delievery/Controller/favorite_controller.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/View/Widegt/favorite_widget.dart';
import 'package:order_delievery/View/Widegt/most_purchased.dart';
import 'package:order_delievery/View/product_page.dart';
import 'package:order_delievery/constans.dart';
import 'package:shimmer/shimmer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteController controller =
      Get.put(FavoriteController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constans.screen,
        appBar: AppBar(
          title:  Padding(
            padding: EdgeInsets.only(left: 130),
            child: Text("31".tr,
                style: TextStyle(
                  fontFamily: Constans.fontFamily,
                  fontSize: 22,
                )),
          ),
          backgroundColor: Constans.screen,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: GetBuilder<FavoriteController>(builder: (controller) {
          return FutureBuilder<List<Product>?>(
              future: FavoriteController().getFavoriteProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return getShimmerFavourite();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return getShimmerFavourite();
                } else if (snapshot.hasData) {
                  List<Product> favoriteList = snapshot.data!;
                  return favoriteList.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 20, left: 7, right: 5, bottom: 10),
                          itemCount: favoriteList.length,
                          clipBehavior: Clip.none,
                          itemBuilder: ((context, index) {
                            return FavoriteWidget(
                              onTap: () {
                                Get.to(ProductPage(
                                  product: favoriteList[index],
                                ));
                              },
                              product: favoriteList[index],
                              widget: GetBuilder<FavoriteController>(
                                  builder: (controller) {
                                return Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.03,
                                  right:
                                      MediaQuery.of(context).size.width * 0.03,
                                  child: IconButton(
                                    onPressed: () {
                                      if (favoriteList[index].favourite ==
                                          false) {
                                        controller
                                            .addToFavorite(
                                                favoriteList[index].id)
                                            .then((value) {
                                          favoriteList[index].favourite = true;
                                          controller.update();
                                        });
                                      } else {
                                        controller
                                            .removeFavorite(
                                                favoriteList[index].id)
                                            .then((value) {
                                          favoriteList[index].favourite = false;
                                          controller.update();
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      favoriteList[index].favourite == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 40,
                                      color:
                                          favoriteList[index].favourite == true
                                              ? const Color(0xffa52a2a)
                                              : Constans.appColor1,
                                    ),
                                  ),
                                );
                              }),
                            );
                          }))
                      : Container(
                          padding: const EdgeInsets.only(top: 300, left: 45),
                          child: Text(
                            "32".tr,
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: Constans.fontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                } else {
                  return getShimmerFavourite();
                }
              });
        }));
  }

  Shimmer getShimmerFavourite() {
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
                height: MediaQuery.of(context).size.height * 0.1,

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
