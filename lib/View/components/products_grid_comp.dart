import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_delievery/Model/Stores&Products.dart';

import '../../constans.dart';
import '../../shops.dart';
import '../product_page.dart';

class ProductsGridComp extends StatelessWidget {
  List<Product> products;
 ProductsGridComp({super.key,required this.products});

  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {

            Get.to(ProductPage(product: products[index]));
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

                          products[index].picture,
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding:  const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            products[index].name.toString(),
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
                            products[index].store_name.toString(),
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
                         products[index].price.toString() ,
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
                Positioned(
                    child: IconButton(
                        onPressed: () {},
                        icon:  Icon(
                          Icons.favorite,
                          size: 30,
                          color: products[index].favourite==true?Color(0xffa52a2a)
                              :Colors.grey,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
