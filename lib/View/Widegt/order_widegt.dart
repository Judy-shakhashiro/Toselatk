import 'package:flutter/material.dart';
import 'package:order_delievery/Model/order.dart';
import 'package:order_delievery/View/components/GradientText.dart';
import 'package:order_delievery/constans.dart';

// ignore: must_be_immutable
class OrderWidget extends StatefulWidget {
  OrderWidget({super.key, this.order, this.onPressed,this.onTap});

  Order? order;
  void Function()? onPressed;
  void Function()? onTap;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Constans.appColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      widget.order!.date!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: Constans.fontFamily,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 5, bottom: 0),
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: widget.onPressed!,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Constans.appColor1),
                        child: const Text('Cancel',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: Constans.fontFamily,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8, right: 5),
                      child: Icon(
                        Icons.price_check_rounded,
                        color: Constans.appColor1,
                        size: 35,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Price",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: Constans.fontFamily),
                        ),
                        Text(
                          r"$"+ widget.order!.price!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: Constans.fontFamily),
                        ),
                      ],
                    ),
                     Padding(
                        padding:const EdgeInsets.only(left: 130, right: 8),
                        child:  Text(
                      widget.order!.status!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: Constans.fontFamily,
                        color: Colors.black87,
                    
                          fontWeight: FontWeight.w500),
                    ),
                      ),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Icon(
                        Icons.format_list_numbered_sharp,
                        color: Constans.appColor1,
                        size: 35,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Item Count",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: Constans.fontFamily),
                        ),
                        Text(
                          widget.order!.products!.length.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: Constans.fontFamily),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: widget.onTap!,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 150, right: 8),
                        child: Icon(
                          Icons.arrow_circle_right_sharp,
                          color: Constans.appColor1,
                          size: 45,
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
              
            ],
          )),
    );
  }
}
