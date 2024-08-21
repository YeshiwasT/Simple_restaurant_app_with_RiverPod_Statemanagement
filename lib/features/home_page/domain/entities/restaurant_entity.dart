class Restaurant {
  final int id;
  final String name;
  final String cuisine;

  final double averageReview;
  final int numberOfReviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.cuisine,
      required this.averageReview,
      required this.numberOfReviews});
}
