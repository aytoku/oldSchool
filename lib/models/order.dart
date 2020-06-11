import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'dart:convert' as convert;
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/models/user.dart';

class Order {
  Records restaurant;
  final FoodRecords food;
  int quantity;
  bool isSelected;
  final String date;

  Order({
    this.restaurant,
    this.food,
    this.date,
    this.isSelected = false,
    this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> parsedJson){
    return new Order(
      food: new FoodRecords(uuid: parsedJson['uuid'], price: parsedJson['price'], name: parsedJson['name']),
      quantity: parsedJson['number'],
      date: DateTime.now().toString(),
      restaurant: Records.fromJson(parsedJson['restaurant'])
    );
  }


  void increaseItemQuantity(Order foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(Order foodItem) => foodItem.decrementQuantity();

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}