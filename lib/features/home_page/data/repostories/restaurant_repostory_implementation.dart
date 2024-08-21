import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repostories/restaurant_repostory.dart';
import '../datasources/local_datasources.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final LocalRestaurantDataSource localDataSource;

  RestaurantRepositoryImpl(this.localDataSource);

  @override
  Future<List<Restaurant>> getRestaurants() async {
    return await localDataSource.getRestaurants();
  }
}
