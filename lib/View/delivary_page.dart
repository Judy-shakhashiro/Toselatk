import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:order_delievery/Model/LoginFuncs.dart';
import 'package:order_delievery/main.dart';
import '../Controller/pages_controller.dart';
import '../constans.dart';
import 'home_page.dart';

// ignore: must_be_immutable
class DelivaryPage extends StatefulWidget {
  const DelivaryPage({super.key});

  @override
  State<DelivaryPage> createState() => _DelivaryPageState();
}

class _DelivaryPageState extends State<DelivaryPage> {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constans.screen,
      appBar: controller.selectedIndex == 0 &&
              controller.selectedIndex != 3 &&
              controller.selectedIndex != 2 &&
              controller.selectedIndex != 1
          ? AppBar(
              title: const Padding(
                padding: EdgeInsets.only(left: 90),
                child: Text("HOME",
                    style: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontSize: 22,
                    )
                    ),
              ),
              backgroundColor: Constans.screen,
              elevation: 0,
              scrolledUnderElevation: 0,
            )
          : null,
      drawer: Drawer(
        width: 240,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40), bottomRight: Radius.circular(40)),
        ),
        child: Container(
          color: Constans.appColor,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(
                        "assets/images/route.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Text(
                      "TOSELATK",
                      style: TextStyle(
                          fontSize: 23,
                          fontFamily: Constans.fontFamily,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: <Color>[
                                Color(0xfff5bd1f),
                                // Color(0xff915f6d),
                                // Color(0xff915f6d),
                                // Color(0xff915f6d),
                                Color(0xffbd0505),
                                Color(0xffffea00),
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 25, right: MediaQuery.of(context).size.width * 0.23),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  height: MediaQuery.of(context).size.height * 0.11,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: Image.asset(
                    fit: BoxFit.cover,
                    "assets/images/profile.jpg",
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, left: 25),
                child: Text(
                  "Sedra Ayman",
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: Constans.fontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 1, left: 25, bottom: 1),
                child: Text(
                  "0935473789",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constans.fontFamily,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/location.png",
                      height: 25,
                      width: 25,
                    ),
                    const Text(
                      "Syria_Damascus",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: Constans.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0.2,
                thickness: 0.1,
                indent: 23,
                endIndent: 23,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: Constans.fontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(const HomePage());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.black,
                ),
                title: const Text(
                  "My orders",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //fontFamily: Constans.fontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  Get.to(const HomePage());
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text(
                  "Log out",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: Constans.fontFamily,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () async {
              //  await  LoginFuncs.logout(userData!.getString('token')!);
                  userData?.remove('token');
                  Get.toNamed('/login');
                  //call logout function from api
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
              gap: 8,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              tabs: [
                const GButton(
                  icon: Icons.home,
                  iconActiveColor: Colors.black,
                  text: "Home",
                  textStyle: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                GButton(
                  icon: Icons.search,
                  iconActiveColor: Colors.black,
                  text: "Search",
                  onPressed: (){
                    Get.toNamed('/home_page');
                  },
                  textStyle: const TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                const GButton(
                  icon: Icons.favorite,
                  iconActiveColor: Colors.black,
                  text: "Favorite",
                  textStyle: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                const GButton(
                  icon: Icons.shopping_cart,
                  iconActiveColor: Colors.black,
                  text: "Cart",
                  textStyle: TextStyle(
                      fontFamily: Constans.fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ],
              selectedIndex: controller.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  controller.selectedIndex = index;
                });
              }),
        ),
      ),
      body: controller.screens[controller.selectedIndex],
    );
  }
}
