import 'dart:convert';

import '../../domain/entities/restaurant_entity.dart';
import '../models/restaurant_model.dart';

class LocalRestaurantDataSource {
  final String jsonString = '''[
    {
        "id": 1,
        "name": "The Smokehouse",
        "cuisine": "Barbecue",
        "avarage_review":3.5,
        "number_of_reviews":40
    },
    {
        "id": 2,
        "name": "Pinocchio's Pizza",
        "cuisine": "Italian",
         "avarage_review":4.0,
        "number_of_reviews":50
    },
    {
        "id": 3,
        "name": "Felipe's Taqueria",
        "cuisine": "Mexican",
         "avarage_review":2.0,
        "number_of_reviews":10
    },
    {
        "id": 4,
        "name": "Tasty Burger",
        "cuisine": "American",
         "avarage_review":5.0,
        "number_of_reviews":30
    }
]''';

  Future<List<Restaurant>> getRestaurants() async {
    final List parsedList = json.decode(jsonString);
    return parsedList.map((data) => RestaurantModel.fromJson(data)).toList();
  }
}
