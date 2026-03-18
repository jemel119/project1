import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'food_detail_screen.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {

  List<Map<String, dynamic>> restaurants = [];

  Future loadRestaurants() async {
    final data = await DatabaseHelper.instance.getRestaurants();
    setState(() => restaurants = data);
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Food Spots")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_food');
          loadRestaurants();
        },
        child: const Icon(Icons.add),
      ),

      body: restaurants.isEmpty
          ? const Center(child: Text("No restaurants yet"))
          : ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, i) {

                final r = restaurants[i];

                return Card(
  child: ListTile(
    title: Text(r['name']),
    subtitle: Text(r['cuisine'] ?? ""),

    onTap: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FoodDetailScreen(restaurant: r),
        ),
      );

      loadRestaurants(); // refresh after returning
    },

    trailing: Icon(
      r['is_favorite'] == 1
          ? Icons.favorite
          : Icons.favorite_border,
      color: Colors.red,
    ),
  ),
);
              },
            ),
    );
  }
}