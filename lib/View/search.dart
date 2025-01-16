import 'package:flutter/material.dart';
import 'package:order_delievery/Model/Stores&Products.dart';
import 'package:order_delievery/View/components/products_grid_comp.dart';
import 'package:order_delievery/View/components/stores_list_comp.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchType = "product"; // Default search type
  bool isLoading = false; // Loading state
  TextEditingController searchWord=TextEditingController();
  List<String> results = []; // Mock search results
  List<Store>? shops=[ ];
  List<Product>? products=[ ];
  void performStoresSearch (String query) async{
    setState(() {
      isLoading = true;
      shops=[];
    });
    shops=await StoresAndProduct.searchStores(query);
      setState(() {
        isLoading = false;
      });

  }
  void performProductsSearch (String query) async{
    setState(() {
      isLoading = true;
      products=[];
    });
    products=await StoresAndProduct.searchProducts(query);
    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 12,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchWord,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search, color: Colors.grey[800]),
                            onPressed: () async {
                              // Add logic for search button
                             if(searchType=="store")
                               performStoresSearch(searchWord.text);
                             else
                              performProductsSearch(searchWord.text);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: searchType,
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              value: "product",
                              child: Text("Product"),
                            ),
                            DropdownMenuItem(
                              value: "store",
                              child: Text("Store"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              searchType = value!;
                            });
                          },
                          dropdownColor: Colors.white,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                          menuMaxHeight: 200,
                          borderRadius: BorderRadius.circular(12), // Rounded dropdown menu
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? LoadingAnimation(searchType: searchType)
                  : (products==null &&searchType=="product"||shops!.isEmpty &&searchType=="store")
                  ? Center(child: Text("No results found"))
                  : searchType == "store"
                  ? StoresListComp(shops: shops!)
                  : ProductsGridComp(products: products!)

            ),
          ],
        ),
      ),
    );
  }
}

class LoadingAnimation extends StatefulWidget {
  final String searchType;
  LoadingAnimation({required this.searchType});
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _animations = List.generate(
      widget.searchType == "store" ? 6 : 6,
          (index) => Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: _controller, curve: Interval(index * 0.2, 1.0))),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchType == "store"
        ? ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            double opacity = _animations[index].value;
            double darkness = 0.4 + (index * 0.1); // Darker as you go down
            return Opacity(
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(darkness),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    )
        : GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
      ),
      itemCount: 6,  // Adjust to match the number of items in the loading animation
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            double opacity = _animations[index].value;
            double darkness = 0.4 + (index * 0.1); // Darker as you go down

            return Opacity(
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!.withOpacity(darkness),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

