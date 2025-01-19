import 'package:flutter/material.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/View/Widegt/most_purchased.dart';
import 'package:order_delievery/View/product_page.dart';
import 'package:order_delievery/constans.dart';

class ProductsOrder extends StatefulWidget {
  ProductsOrder({super.key, this.products});
  List<Product>? products;

  @override
  State<ProductsOrder> createState() => _ProductsOrderState();
}

class _ProductsOrderState extends State<ProductsOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constans.screen,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text("OREDER DETAILS",
                style: TextStyle(
                  fontFamily: Constans.fontFamily,
                  fontSize: 22,
                )),
          ),
          backgroundColor: Constans.screen,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: GridView.builder(
            padding:
                const EdgeInsets.only(top: 20, left: 7, right: 5, bottom: 10),
            itemCount: widget.products!.length,
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 35,
              crossAxisSpacing: 16,
            ),
            itemBuilder: ((context, index) {
              return MostPurchased(
                product: widget.products![index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                                product: widget.products![index],
                              )));
                },
              );
            })));
  }
}
