import 'dart:convert';

import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel extends Restaurant {
  RestaurantModel(
      {required super.id,
      required super.name,
      required super.cuisine,
      required super.averageReview,
      required super.numberOfReviews});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        id: json['id'],
        name: json['name'],
        cuisine: json['cuisine'],
        averageReview: json['avarage_review'],
        numberOfReviews: json['number_of_reviews']);
  }
}
