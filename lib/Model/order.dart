import 'package:order_delievery/Model/Stores&Products.dart';

class Order {
  dynamic id;
  String? status;
  String? date;
  String? price;
  List<Product>? products;

  Order({
    this.id,
    this.status,
    this.date,
    this.price,
    this.products,
  });

  factory Order.fromJson(dynamic jsonData, int i) {
    List<Product>? products = [];
    if (jsonData[i]["order_list"] != null &&
        jsonData[i]["order_list"].isNotEmpty) {
      for (var j = 0; j < jsonData[i]["order_list"].length; j++) {
        products.add(Product.fromJson1(jsonData[i]["order_list"], j));
      }
    }


    DateTime createdAt = DateTime.parse(jsonData[i]['created_at']);

    String year = createdAt.year.toString();
    String month = createdAt.month
        .toString()
        .padLeft(2, '0'); 
    String day = createdAt.day
        .toString()
        .padLeft(2, '0'); 

    String formattedDate = '$day-$month-$year';

    return Order(
      id: jsonData[i]['id'],
      status: jsonData[i]['status'],
      price: jsonData[i]['total_price'],
      date: formattedDate,
      products: products,
    );
  }
}
