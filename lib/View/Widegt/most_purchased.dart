import 'package:flutter/material.dart';
import '../../Model/Stores&Products.dart';
import '../../constans.dart';
// ignore: must_be_immutable
class MostPurchased extends StatelessWidget {
  MostPurchased({super.key, this.onTap, this.product});
  Product? product;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.height * 0.21,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black),
                    child: Image.network(
                      fit: BoxFit.cover,
                      product!.picture,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        product!.name,
                        style: const TextStyle(
                          fontFamily: Constans.fontFamily,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        product!.store_name!,
                        style: const TextStyle(
                          fontFamily: Constans.fontFamily,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      product!.price.toString(),
                      style: const TextStyle(
                        fontFamily: Constans.fontFamily,
                        fontSize: 15,
                        color: Color(0xffa52a2a),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                child: Icon(
              product!.favourite == false
                  ? Icons.favorite_border
                  : Icons.favorite,
              size: 30,
              color: const Color(0xffa52a2a),
            ))
          ],
        ),
      ),
    );
  }
}
