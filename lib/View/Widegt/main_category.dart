import 'package:flutter/material.dart';

import '../../constans.dart';


// ignore: must_be_immutable
class MainCategory extends StatelessWidget {
  MainCategory({
    super.key,
    this.onTap,
    this.icon,
    required this.text,
  });
  void Function()? onTap;
  String? text;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2),
      child: Column(
        children: [
          InkWell(
              onTap: onTap,
              child: CircleAvatar(
                backgroundColor: Constans.screen,
                radius: 30,
                child: Image.asset(
                  icon!,
                  height: 35,
                  width: 35,
                ),
              )),
          Text(
            text!,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: Constans.fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
