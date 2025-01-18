import 'package:flutter/material.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/constans.dart';

// ignore: must_be_immutable
class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({super.key, this.product, this.widget,this.onTap});
  int? amount = 1;
  Product? product;
  Widget? widget;
  void Function()? onTap;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black),
                    child: Image.network(
                      fit: BoxFit.cover,
                      widget.product!.picture,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, left: 15),
                        child: Text(
                          widget.product!.name,
                          style: const TextStyle(
                            fontFamily: Constans.fontFamily,
                            fontSize: 23,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          r"$" + widget.product!.price.toString(),
                          style: const TextStyle(
                            fontFamily: Constans.fontFamily,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            widget.widget!,
          ],
        ),
      ),
    );
  }
}
