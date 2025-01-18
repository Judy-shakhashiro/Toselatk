import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:order_delievery/View/cart_page.dart';
import 'package:order_delievery/View/favorite.dart';

import '../View/home_page.dart';
import '../View/search.dart';


class NavigationController extends GetxController {
  int selectedIndex = 0;
  List screens = [
    const HomePage(),
    SearchScreen(),
     const FavoritePage(),
    const CartPage(),
    
  ];
}
