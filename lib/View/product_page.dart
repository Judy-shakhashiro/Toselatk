import 'package:flutter/material.dart';

import '../Model/Stores&Products.dart';
import '../constans.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  final Product? product;
  int amount = 1;

  ProductPage({super.key,  this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // Use a fallback product if the provided product is null
    final product = widget.product ??
      const   Product(
          name: "Default Product",
          picture: "assets/default_image.png", // Provide a default image
          description: "No description available.",
          store_id:23,
          price: 233,
          store_name: " default store",
        id: 1,
        favourite: false
        );

    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image section
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(48),
                      bottomLeft: Radius.circular(48),
                    ),
                    color: Colors.white,
                  ),
                  child: Image.network(
                    product.picture,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 30,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
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
                  top: MediaQuery.of(context).size.height * 0.466,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      size: 40,
                      color: product.favourite==true?Colors.red:
                      Colors.grey
                      ,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Product details section
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 23),
                  child: Text(
                    product.name!,
                    style: const TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.only(top: 0, left: 24),
                  child: Text(
                    product.store_name!,
                    style: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 24),
                      child: Text(
                        product.price.toString(),
                        style: TextStyle(
                          fontFamily: Constans.fontFamily,
                          fontSize: 24,
                          color: Constans.appColor1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.5,
                        top: 10,
                      ),
                      child: Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.amount++;
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            Text(
                              "${widget.amount}",
                              style: const TextStyle(
                                fontFamily: Constans.fontFamily,
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (widget.amount > 1) widget.amount--;
                                });
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "About Product",
                    style: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child:product.description==null ?Text(
                          product.description!,
                          style: const TextStyle(
                            fontFamily: Constans.fontFamily,
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ):Text(" ")
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Add to Cart button
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constans.appColor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Add to cart",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: Constans.fontFamily,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
