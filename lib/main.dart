import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_delievery/locale.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MiddleWare/HomeMiddleWare.dart';
import 'View/AnimationPage.dart';
import 'View/DataEntry.dart';
import 'View/Stores.dart';
import 'View/create_account.dart';
import 'View/delivary_page.dart';
import 'View/home_page.dart';
import 'View/login.dart';
import 'View/pinputcomp.dart';
import 'View/product_page.dart';
import 'View/products_of_store.dart';
import 'View/search.dart';
SharedPreferences? userData;
String back_url="http://10.65.10.158:8000";
String lang="en";
//
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  userData= await SharedPreferences.getInstance();
  if(Get.deviceLocale.toString()=="ar_LB") {
    lang="ar";
  } else {
    lang="en";
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
locale: Get.deviceLocale,
translations: Translation(),
debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


    textTheme: const TextTheme(

      headlineMedium: TextStyle(fontWeight: FontWeight.w700,fontSize: 35,letterSpacing: 2),

    )
    ),

    initialRoute: '/splash',
    getPages:[
      GetPage(name: '/splash', page: ()=> const AnimationPage()),
      GetPage(name: '/create_account', page: ()=>CreateAccount()),
      GetPage(name: '/home_page', page:()=> const HomePage()),
      GetPage(name: '/login', page: () =>  Login(),middlewares: [HomeMiddleWare()]),
      GetPage(name: '/pinput_comp', page: ()=> const PinputComp()),
      GetPage(name: '/delivery', page: ()=> const DelivaryPage()),
      GetPage(name: '/dataEntry', page: ()=>const InfoAccount()),
      GetPage(name: '/stores', page: ()=> Stores(kind: '',)),
      GetPage(name: '/products_of_store', page:  ()=> const ProductsOfStore()),
      GetPage(name: '/product', page: ()=>ProductPage()),
      GetPage(name: '/search', page: ()=>  SearchScreen())
    ]
        
    );
}}
