import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/View/product_page.dart';
import '../Model/Stores&Products.dart';
import '../constans.dart';
import '../main.dart';
import '../shops.dart';

import 'Stores.dart';



class ProductsOfStore extends StatefulWidget {
  const ProductsOfStore({super.key});

  @override
  State<ProductsOfStore> createState() => _ProductsOfStoreState();
}

class _ProductsOfStoreState extends State<ProductsOfStore> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
               child:  Image.network(Shops.shops![storeChosen].url),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(right: 4),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                top: 250,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(1),
                        Colors.white.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 2,
                        left: 10,
                        child: Text(
                          Shops.shops![storeChosen].name,
                          style: const TextStyle(
                            letterSpacing: 4,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 10,
                        child: Text(
                         " ${"25".tr} ':' ${Shops.shops?[storeChosen].location}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 10,
                        child: Text(
                          " ${Shops.shops?[storeChosen].description}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          SizedBox(child: Text("26".tr,style:
          TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
            )),
          SizedBox(height: 10,),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Shops.products!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {

                  Get.to(ProductPage(product:  Shops.products![index]));
                },
               child:  Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 7),
                 child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.height * 0.21,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black),
                              child: Image.network(

                                Shops.products![index].picture,
                              ),
                            ),
                           SingleChildScrollView(
                              child: Padding(
                                padding:  const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  Shops.products![index].name.toString(),
                                  style:  const TextStyle(
                                    fontFamily: Constans.fontFamily,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                             SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text(
                                  Shops.products![index].store_name.toString(),
                                  style: TextStyle(
                                    fontFamily: Constans.fontFamily,
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                           Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                Shops.products![index].price.toString() ,
                                style: TextStyle(
                                  fontFamily: Constans.fontFamily,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right : lang=="en"? 0 :150),

                        child: Positioned(

                            child: IconButton(
                                onPressed: () {},
                                icon:  Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: Shops.products![index].favourite==true?Color(0xffa52a2a)
                                  :Colors.white10,
                                ))),
                      )
                    ],
                  ),
               ),
              );
            },
          ),
        ],
      ),
    );
  }
}
