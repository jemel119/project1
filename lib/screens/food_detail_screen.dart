import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class FoodDetailScreen extends StatefulWidget {

  final int restaurantId;

  const FoodDetailScreen({super.key, required this.restaurantId});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {

  Map<String, dynamic>? restaurant;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRestaurant();
  }

  Future loadRestaurant() async {

    final data =
        await DatabaseHelper.instance.getRestaurant(widget.restaurantId);

    setState(() {
      restaurant = data;
      isLoading = false;
    });
  }

  Future deleteRestaurant() async {

    await DatabaseHelper.instance.deleteRestaurant(widget.restaurantId);

    Navigator.pop(context);
  }

  Future toggleFavorite() async {

    int currentValue = restaurant!['is_favorite'];

    await DatabaseHelper.instance.updateRestaurant(widget.restaurantId, {
      'is_favorite': currentValue == 1 ? 0 : 1
    });

    loadRestaurant();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Restaurant Details"),
        actions: [

          IconButton(
            icon: Icon(
              restaurant?['is_favorite'] == 1
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: toggleFavorite,
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteRestaurant,
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    restaurant!['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text("Cuisine: ${restaurant!['cuisine']}"),

                  const SizedBox(height: 10),

                  Text("Price: ${restaurant!['price_range']}"),

                  const SizedBox(height: 10),

                  Text("Open Hours: ${restaurant!['open_hours']}"),

                  const SizedBox(height: 10),

                  Text("Notes: ${restaurant!['notes']}"),

                ],
              ),
            ),
    );
  }
}