import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:order_delievery/Controller/Cart_controller.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/constans.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({
    super.key,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constans.screen,
      appBar: AppBar(
        backgroundColor: Constans.screen,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 28,
            )),
      ),
      body: Form(
        key: controller.formKeyAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 40),
              child: Text(
                'Payment Details',
                style: TextStyle(
                  fontFamily: Constans.fontFamily,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                onSaved: (value) {
                  controller.name = value;
                },
                controller: controller.namecon,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                onSaved: (value) {
                  controller.cardnumber = value;
                },
                controller: controller.cardcon,
                decoration: InputDecoration(
                  hintText: 'Enter your card number',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                onSaved: (value) {
                  controller.location = value;
                },
                controller: controller.locationcon,
                decoration: InputDecoration(
                  hintText: 'Enter your location',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        controller.isloading = true;
                      });
                      try {
                        controller.formKeyAll.currentState!.save();
                        print(controller.namecon.text);
                        print(controller.locationcon.text);
                        print(controller.cardcon.text);

                        await controller.addOrder().then((value) {
                          controller.update();
                          controller.namecon.clear();
                          controller.locationcon.clear();
                          controller.cardcon.clear();
                        });
                      } catch (e) {
                        Get.snackbar(
                            'Error', 'No Internet. Please try again later.',
                            backgroundGradient: const LinearGradient(
                                colors: [Colors.red, Colors.white]),
                            snackPosition: SnackPosition.BOTTOM);
                      }

                      setState(() {
                        controller.isloading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // حواف مدورة
                      ),
                      backgroundColor: Constans.appColor1,
                    ),
                    child: controller.isloading == false
                        ? const Text('Pay Now',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Constans.fontFamily,
                              color: Colors.black,
                            ))
                        : const CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
