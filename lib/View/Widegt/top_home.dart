import 'package:flutter/material.dart';

import '../../constans.dart';


// ignore: must_be_immutable
class TopHomePage extends StatelessWidget {
  TopHomePage(
      {super.key,
      this.image,
      this.opacity,
      this.text1,
      this.text2,
      this.right1,
      this.right2});
  double? opacity;
  double? right1;
  double? right2;
  String? image;
  String? text1;
  String? text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Opacity(
              opacity: opacity!,
              child: Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                image!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              right: MediaQuery.of(context).size.width * right1!,
              child: Text(
                text1!,
                style: const TextStyle(
                    fontFamily: Constans.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.04,
              right: MediaQuery.of(context).size.width * right2!,
              child: Text(
                text2!,
                style: const TextStyle(
                    fontFamily: Constans.fontFamily,
                    fontSize: 14,
                    color: Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}
