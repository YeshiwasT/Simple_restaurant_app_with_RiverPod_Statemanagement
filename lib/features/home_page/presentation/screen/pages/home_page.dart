import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/size_config.dart';
import '../providers/get_restaurant_provider.dart';
import 'widgets/restaurant_card.dart';

class RestaurantListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRestaurants = ref.watch(filteredRestaurantsProvider);
    final selectedCuisine = ref.watch(selectedCuisineProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Restaurants'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Container(
                          padding: const EdgeInsets.only(
                            left: 4,
                            right: 8,
                            top: 1,
                            bottom: 1,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6F9),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {},
                                child: TextFormField(
                                  onChanged: (value) {
                                    ref
                                        .read(searchQueryProvider.notifier)
                                        .state = value;
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Search",
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ), // Adjust the vertical padding
                                        child: Icon(Icons.search)),
                                  ),
                                  validator: (value) => null,
                                ),
                              ),
                            ),
                          ))),
                  Container(
                    height: SizeConfig.screenHeight * 0.055,
                    width: SizeConfig.screenHeight * 0.059,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF4F6F9),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          showModalBottomSheet(
                            elevation: 1,
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  value: selectedCuisine,
                                  hint: const Text('Select cuisine'),
                                  items: const [
                                    DropdownMenuItem(
                                        value: null, child: Text('All')),
                                    DropdownMenuItem(
                                        value: 'Barbecue',
                                        child: Text('Barbecue')),
                                    DropdownMenuItem(
                                        value: 'Italian',
                                        child: Text('Italian')),
                                    DropdownMenuItem(
                                        value: 'Mexican',
                                        child: Text('Mexican')),
                                    DropdownMenuItem(
                                        value: 'American',
                                        child: Text('American')),
                                  ],
                                  onChanged: (value) {
                                    ref
                                        .read(selectedCuisineProvider.notifier)
                                        .state = value;
                                    Navigator.pop(context);
                                  },
                                  isExpanded: true,
                                ),
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14),
                          child: Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: asyncRestaurants.when(
              data: (restaurants) => ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    restaurant: restaurants[index],
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
