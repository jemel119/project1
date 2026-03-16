import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {

  Map<String, dynamic>? recommendation;
  String reason = "";

  @override
  void initState() {
    super.initState();
    generateRecommendation();
  }

  Future generateRecommendation() async {

    final restaurants = await DatabaseHelper.instance.getRestaurants();

    if (restaurants.isEmpty) {
      setState(() {
        reason = "Add restaurants first to get recommendations.";
      });
      return;
    }

    // Step 1: Check favorites
    final favorites =
        restaurants.where((r) => r['is_favorite'] == 1).toList();

    if (favorites.isNotEmpty) {

      setState(() {
        recommendation = favorites.first;
        reason = "You marked this as a favorite.";
      });

      return;
    }

    // Step 2: Find most common cuisine
    Map<String, int> cuisineCount = {};

    for (var r in restaurants) {

      String cuisine = r['cuisine'] ?? "Other";

      cuisineCount[cuisine] = (cuisineCount[cuisine] ?? 0) + 1;
    }

    String mostCommonCuisine =
        cuisineCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    final matches = restaurants
        .where((r) => r['cuisine'] == mostCommonCuisine)
        .toList();

    setState(() {
      recommendation = matches.first;
      reason = "You often choose $mostCommonCuisine food.";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Food Recommendation"),
      ),

      body: Center(

        child: recommendation == null
            ? Text(reason)

            : Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Icon(
                    Icons.restaurant_menu,
                    size: 80,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    recommendation!['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text("Cuisine: ${recommendation!['cuisine']}"),

                  const SizedBox(height: 10),

                  Text("Price: ${recommendation!['price_range']}"),

                  const SizedBox(height: 20),

                  Text(
                    "Why this suggestion:",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  Text(reason),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: generateRecommendation,
                    child: const Text("Suggest Another"),
                  )

                ],
              ),
      ),
    );
  }
}