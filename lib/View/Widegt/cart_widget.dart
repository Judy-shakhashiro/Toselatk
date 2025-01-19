import 'package:flutter/material.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/constans.dart';

// ignore: must_be_immutable
class CartWidget extends StatefulWidget {
  CartWidget({super.key, this.product, this.onPressed,this.widget});
  int? amount = 1;
  Product? product;
  void Function()? onPressed;
  Widget? widget;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(7),
              clipBehavior: Clip.antiAlias,
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.black),
              child: Image.network(
                fit: BoxFit.cover,
                widget.product!.picture,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1, left: 0),
                  child: Text(
                    widget.product!.name,
                    style: const TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 10),
                  child: Text(
                    r"$" "${widget.product!.price.toString()} for one",
                    style: const TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Constans.appColor1,
                            borderRadius: BorderRadius.circular(5)),
                        child: widget.widget!),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: IconButton(
                          onPressed: widget.onPressed!,
                          icon: const Icon(
                            Icons.cancel_presentation_rounded,
                            color: Colors.black,
                            size: 28,
                          )),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
