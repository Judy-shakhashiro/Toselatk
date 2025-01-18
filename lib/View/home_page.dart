import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/Controller/mostPurchased_controller.dart';
import 'package:order_delievery/View/Stores.dart';
import 'package:order_delievery/View/product_page.dart';
import 'package:order_delievery/shops.dart';
import 'package:shimmer/shimmer.dart';
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
  MostPurchasedController controller =
      Get.put(MostPurchasedController(), permanent: true);
  List<Widget> topHome = [
    TopHomePage(
      opacity: 0.5,
      right1: 0.45,
      right2: 0.48,
      image: "assets/images/d.jpg",
      text1: "Fastest Delivary",
      text2: "& Free Delivary",
    ),
    TopHomePage(
      opacity: 0.8,
      right1: 0.55,
      right2: 0.28,
      image: "assets/images/ddd.jpg",
      text1: "Locate You",
      text2: "& Your order will reach you",
    ),
    TopHomePage(
      opacity: 0.8,
      right1: 0.45,
      right2: 0.41,
      image: "assets/images/dddd.jpg",
      text1: "Shopping online",
      text2: "& Saving your time ",
    ),
  ];

  Future<List<Product>?>? mostPurchased;

  @override
  void initState() {
    super.initState();

    mostPurchased = MostPurchasedController().getMostPurchased();
  }

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
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
            )),
        Padding(
          padding: EdgeInsets.only(
              top: 5, left: MediaQuery.of(context).size.width * 0.38),
          child: AnimatedSmoothIndicator(
            activeIndex: curruntIndex,
            count: 3,
            effect: const SwapEffect(
                dotHeight: 12,
                dotWidth: 12,
                spacing: 16,
                activeDotColor: Colors.black),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 9, left: 12, bottom: 2),
          child: Text("Category",
              style: TextStyle(
                fontSize: 20,
                fontFamily: Constans.fontFamily,
                color: Colors.black,
              )
              // fontWeight: FontWeight.bold),
              ),
        ),
        SizedBox(
          height: 90,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            MainCategory(
              text: "Clothes",
              icon: "assets/images/boutique.png",
              onTap: () async {
                Shops.shops = await StoresAndProduct.storesByType("1");
                Get.to(() => Stores(kind: "assets/images/boutique.png"));
              },
            ),
            MainCategory(
              text: "Home&Living",
              icon: "assets/images/living-room.png",
              onTap: () async {
                Shops.shops = await StoresAndProduct.storesByType("2");
                Get.to(() => Stores(kind: "assets/images/living-room.png"));
              },
            ),
            MainCategory(
              text: "Beauty",
              icon: "assets/images/beauty-salon.png",
              onTap: () async {
                Shops.shops = await StoresAndProduct.storesByType("3");
                Get.to(() => Stores(kind: "assets/images/beauty-salon.png"));
              },
            ),
            MainCategory(
              text: "Electronics",
              icon: "assets/images/gadget-store.png",
              onTap: () async {
                Shops.shops = await StoresAndProduct.storesByType("4");
                Get.to(() => Stores(kind: "assets/images/gadget-store.png"));
              },
            ),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 2, left: 12, bottom: 10),
          child: Text("Most purchased",
              style: TextStyle(
                fontSize: 20,
                fontFamily: Constans.fontFamily,
                color: Colors.black,
              )
              // fontWeight: FontWeight.bold),
              ),
        ),
        FutureBuilder<List<Product>?>(
            future: mostPurchased,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return getShimmermostPurchased();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null) {
                return getShimmermostPurchased();
              } else if (snapshot.hasData) {
                List<Product> mostPurchasedList = snapshot.data!;
                return mostPurchasedList.isNotEmpty
                    ? SizedBox(
                        height: 230,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mostPurchasedList.length,
                            itemBuilder: (context, index) {
                              return MostPurchased(
                                product: mostPurchasedList[index],
                                onTap: () {
                                  Get.to(ProductPage(
                                    product: mostPurchasedList[index],
                                  ));
                                },
                              );
                            }),
                      )
                    : Container();
              } else {
                return getShimmermostPurchased();
              }
            })
      ]),
    );
  }

  Shimmer getShimmermostPurchased() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Card(
                // margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.height * 0.21,
                  color: Colors.white,
                ),
              );
            }),
      ),
    );
  }
}
