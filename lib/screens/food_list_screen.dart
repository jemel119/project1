import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../widgets/restaurant_card.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {

  List<Map<String, dynamic>> restaurants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  Future loadRestaurants() async {

    final data = await DatabaseHelper.instance.getRestaurants();

    setState(() {
      restaurants = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Food Spots"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          : restaurants.isEmpty
          ? const Center(
              child: Text(
                "No food spots added yet.\nTap + to add one.",
                textAlign: TextAlign.center,
              ),
            )

          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {

                final restaurant = restaurants[index];

                return RestaurantCard(
                  name: restaurant['name'],
                  cuisine: restaurant['cuisine'] ?? "",
                  priceRange: restaurant['price_range'] ?? "",
                  onTap: () {},
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.pushNamed(context, '/add_food').then((_) {
      loadRestaurants();
    });
  },
  child: const Icon(Icons.add),
),
    );
  }
}