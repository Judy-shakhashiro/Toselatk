import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_delievery/View/components/stores_list_comp.dart';
import '../Model/Stores&Products.dart';
import '../constans.dart';
import '../shops.dart';

late  int storeChosen;
final ScrollController _scrollController = ScrollController();
class Stores extends StatefulWidget {

 String kind;
 Stores({super.key, required this.kind});
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Constans.screen,
      appBar: AppBar(leadingWidth: 100,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white38,
        title:
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Constans.screen,
              radius: 30,
              child: Image.asset(
                widget.kind,
                height: 35,
                width: 35,
              ),
            ),
            const Text("Stores", style: TextStyle(
              letterSpacing: 4,
              shadows: [
                Shadow(
                    color: Colors.black45, offset: Offset(2, 2), blurRadius: 10)
              ],
              fontSize: 35,
              fontWeight: FontWeight.w500,
              color: Colors.black87,

            ),),
          ],
        ),),
      body:
      ListView.builder(
        controller: _scrollController,
        itemCount: Shops.shops?.length, // Number of items
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _scrollController,
            builder: (context, child) {
              // Calculate the position of the item relative to the center of the screen
              final itemPosition = _getItemPosition(index, screenHeight);
              final scale = _calculateScale(itemPosition);

              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: _buildListItem(index),
          );
        },
      ),


    );
  }

}

Widget _buildListItem(int index) {
  return InkWell(
    onTap: () async{
      storeChosen=index;
     Shops.products= await StoresAndProduct.productsByStore(Shops.shops![storeChosen].id.toString());
      Get.toNamed('/products_of_store');
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      child: Container(

        height: 150.0, // Fixed height for each list item
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [Positioned(
            top: 50,
            left: 190,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ' ${Shops.shops?[index].name}',
                  style:const  TextStyle(
                    letterSpacing: 2,
                    shadows: [Shadow(color: Colors.black45,offset: Offset(2, 2),blurRadius: 10)],
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,

                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  ' ${Shops.shops?[index].description}',
                  style:const  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
            Positioned(
                left: 5,
                top: 5,
                bottom: 5,
                right: 250,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 20,spreadRadius: 2)]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                    Image.network(Shops.shops![index].url),
                  ),
                ))],
        ),
      ),
    ),
  );
}
double _getItemPosition(int index, double screenHeight) {
  // Calculate the pixel offset for the current item
  if (!_scrollController.hasClients) return 0.0;
  final offset = _scrollController.offset;
  final itemHeight = 150.0; // Fixed height of each list item
  final itemCenter = (index * itemHeight) + (itemHeight / 2.0);

  // Get the screen's vertical center position
  final screenCenter = offset + (screenHeight / 2.0);

  // Return the distance of the item's center from the screen's center
  return (itemCenter - screenCenter).abs();
}

double _calculateScale(double distanceFromCenter) {
  // Calculate scaling factor based on distance from the center
  const maxScale = 1.1; // The largest size the center item can grow to
  const minScale = 0.9; // The smallest size for off-center items
  const maxDistance = 300.0; // The maximum distance for the scaling effect

  // Scale decreases as the item gets farther from the center
  return (maxScale - (distanceFromCenter / maxDistance))
      .clamp(minScale, maxScale);
}
