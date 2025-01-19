import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/View/Stores.dart';
import 'package:order_delievery/View/product_page.dart';
import 'package:order_delievery/main.dart';
import 'package:order_delievery/shops.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../Model/Stores&Products.dart';

import '../constans.dart';
import 'Widegt/main_category.dart';
import 'Widegt/most_purchased.dart';
import 'Widegt/top_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curruntIndex = 0;
  List<Widget> topHome = [
    TopHomePage(
      opacity: 0.5,
      right1: 0.48,
      right2: 0.48,
      image: "assets/images/d.jpg",
      text1: "14".tr,
      text2: "15".tr,
    ),
    TopHomePage(
      opacity: 0.8,
      right1: 0.55,
      right2: 0.48,
      image: "assets/images/ddd.jpg",
      text1: "16".tr,
      text2: "17".tr,
    ),
    TopHomePage(
      opacity: 0.8,
      right1: 0.45,
      right2: 0.48,
      image: "assets/images/dddd.jpg",
      text1: "18".tr,
      text2: "19".tr,
    ),
  ];
  List<Product> products = [
   const  Product(
     favourite: false,
        name: "Water Bottle",
        picture: "assets/images/cup.jpg",
        description:
            "Portable container designed for holding liquids, primarily water, making it convenient for people to stay hydrated throughout the day",
        store_id: 45,
        price: 23,
   id: 2,
   store_name: "any"),
    Product(
        name: "Money wallet",
        store_id: 3456,
        favourite: true,
        picture: "assets/images/wallet.jpg",
        store_name: "any",
        id: 3,
        description:
            "Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.", price: 34),
    Product(
      favourite: false,
        name: "HeadPhone",
        store_name: "any",
        store_id: 245,
        id: 2,
        picture: "assets/images/headphone.jpg",
        description:
            "Portable container designed for holding liquids, primarily water, making it convenient for people to stay hydrated throughout the day",
        price: 234)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constans.screen,
      body: ListView(children: [
        CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIdx) {
              return topHome[index];
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  curruntIndex = index;
                });
              },
              viewportFraction: 0.99,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 6),
            )),
        Padding(
          padding: EdgeInsets.only(
              top: 5, left: MediaQuery.of(context).size.width * 0.38
          ),
          child: AnimatedSmoothIndicator(
            activeIndex: curruntIndex,
            count: 3,
           textDirection:  lang=="ar"?TextDirection.ltr:TextDirection.ltr,
            effect: const SwapEffect(
                dotHeight: 12,
                dotWidth: 12,
                spacing: 16,
                activeDotColor: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9, left: 12, bottom: 2),
          child: Text("6".tr,
              style: TextStyle(

                shadows: [
                  Shadow(
                      color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)
                ],
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black87,

              )
              // fontWeight: FontWeight.bold),
              ),
        ),
        SizedBox(
          height: 90,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            MainCategory(
              text: "20".tr,
              icon: "assets/images/boutique.png",
              onTap: () async {
                Shops.shops= await StoresAndProduct.storesByType("1");
                Get.to(()=> Stores(kind: "assets/images/boutique.png"));
              },
            ),
            MainCategory(
              text: "21".tr,
              icon: "assets/images/living-room.png",
              onTap: () async {
                Shops.shops= await StoresAndProduct.storesByType("2");
                Get.to(()=> Stores(kind: "assets/images/living-room.png"));
              },
            ),
            MainCategory(
              text: "22".tr,
              icon: "assets/images/beauty-salon.png",
              onTap: () async {
                Shops.shops=await StoresAndProduct.storesByType("3");
                Get.to(()=> Stores(kind: "assets/images/beauty-salon.png"));
              },
            ),
            MainCategory(
              text: "23".tr,
              icon: "assets/images/gadget-store.png",
              onTap: () async {
                Shops.shops= await StoresAndProduct.storesByType("4");
                Get.to(()=> Stores(kind: "assets/images/gadget-store.png"));
              },
            ),
          ]),
        ),
         Padding(
          padding: EdgeInsets.only(top: 2, left: 12, bottom: 10),
          child: Text("7".tr,
              style: TextStyle(

                fontFamily: Constans.fontFamily,
                shadows: [
                  Shadow(
                      color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)
                ],
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.black87,

              )
              // fontWeight: FontWeight.bold),
              ),
        ),
        SizedBox(
          height: 250,

            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return MostPurchased(

                    product: products[index],
                    onTap: () {
                      Get.to(ProductPage(
                        product: products[index],
                      ));
                    },
                  );
                }),
          ),

      ]),
    );
  }
}
