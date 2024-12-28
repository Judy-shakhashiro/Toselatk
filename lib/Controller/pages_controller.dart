import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../View/home_page.dart';


class NavigationController extends GetxController {
  int selectedIndex = 0;
  List screens = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
    
  ];
}
