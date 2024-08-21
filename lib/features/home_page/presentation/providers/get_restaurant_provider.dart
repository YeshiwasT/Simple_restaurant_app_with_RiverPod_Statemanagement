import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_datasources.dart';
import '../../data/repostories/restaurant_repostory_implementation.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/repostories/restaurant_repostory.dart';
import '../../domain/usecases/get_restaurant_usecase.dart';

// Provider for the selected cuisine filter
final selectedCuisineProvider = StateProvider<String?>((ref) => null);

// Repository Provider
final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) => RestaurantRepositoryImpl(LocalRestaurantDataSource()),
);

// Use Case Provider
final getRestaurantsProvider = Provider<GetRestaurants>(
  (ref) => GetRestaurants(ref.read(restaurantRepositoryProvider)),
);

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');
//  filteredRestaurantsProvider to filter by cuisine and search
final filteredRestaurantsProvider =
    FutureProvider<List<Restaurant>>((ref) async {
  final getRestaurants = ref.read(getRestaurantsProvider);
  final restaurants = await getRestaurants();

  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedCuisine = ref.watch(selectedCuisineProvider);

  return restaurants.where((restaurant) {
    final matchesName = restaurant.name.toLowerCase().contains(query);
    final matchesCuisine =
        selectedCuisine == null || restaurant.cuisine == selectedCuisine;
    return matchesName && matchesCuisine;
  }).toList();
});
