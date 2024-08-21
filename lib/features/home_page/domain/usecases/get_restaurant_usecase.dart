import '../entities/restaurant_entity.dart';
import '../repostories/restaurant_repostory.dart';

class GetRestaurants {
  final RestaurantRepository repository;

  GetRestaurants(this.repository);

  Future<List<Restaurant>> call() {
    return repository.getRestaurants();
  }
}
