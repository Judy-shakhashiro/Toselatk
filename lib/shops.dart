import 'package:order_delievery/Model/Stores&Products.dart';

import 'Model/Stores&Products.dart';



class Shops{

  static List<Store>? shops
  =
  const [
     Store(name: "Asma", typeId: 1, description: "description",
         url: "assets/images/4.png",
         location: "Damascus -AboRemaneh"),
     Store(name: "Judy Library", typeId: 1, description: "go and dive into world of books..all kinds",
     url: "assets/images/1.png",
     location: "Damascus -AboRemaneh",)
  ];

  static List<Product>? products
  =
  [
   const  Product (
        name: "Water Bottle",
        store_id:2345,
        picture: "assets/images/cup.jpg",
        description:
        "Portable container designed for holding liquids, primarily water, making it convenient for people to stay hydrated throughout the day",
        price: 23),
    const Product(
        name: "Money wallet",
        store_id: 235,
        picture: "assets/images/wallet.jpg",
        price: 234,
        description:
        "Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards.Portable case designed to hold and organize personal items, primarily money, identification, and payment cards."
    ),

   const  Product(
        name: "HeadPhone",
        store_id: 2345,
        picture: "assets/images/headphone.jpg",
        description:
        "Portable container designed for holding liquids, primarily water, making it convenient for people to stay hydrated throughout the day", price: 23)
  ];
}