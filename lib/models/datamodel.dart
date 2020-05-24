import 'dart:convert';

import 'package:flutter/services.dart';

// To parse this JSON data, do
//
//     final foodData = foodDataFromJson(jsonString);

Future<String> _loadAJsonAsset() async {
  return await rootBundle.loadString('assets/json/data.json');
}

// To parse this JSON data, do
//
//     final foodData = foodDataFromJson(jsonString);

List<FoodData> foodDataFromJson(String str) =>
    List<FoodData>.from(json.decode(str).map((x) => FoodData.fromMap(x)));

String foodDataToJson(List<FoodData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class FoodData {
  String categoryId;
  String categories;
  String itemId;
  String engishName;
  String price;
  String image;

  FoodData({
    this.categoryId,
    this.categories,
    this.itemId,
    this.engishName,
    this.price,
    this.image,
  });

  factory FoodData.fromMap(Map<String, dynamic> json) => FoodData(
        categoryId: json["CATEGORY_ID"],
        categories: json["Categories"],
        itemId: json["ITEM_ID"],
        engishName: json["ENGISH_NAME"],
        price: json["PRICE"],
        image: json["Image"],
      );

  Map<String, dynamic> toMap() => {
        "CATEGORY_ID": categoryId,
        "Categories": categories,
        "ITEM_ID": itemId,
        "ENGISH_NAME": engishName,
        "PRICE": price,
        "Image": image,
      };
}
