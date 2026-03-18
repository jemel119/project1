import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {

  Map<String, dynamic>? restaurant;

  Future loadRecommendation() async {
    final r = await DatabaseHelper.instance.getRecommendedRestaurant();
    setState(() => restaurant = r);
  }

  @override
  void initState() {
    super.initState();
    loadRecommendation();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Recommendation")),

      body: Center(
        child: restaurant == null
            ? const Text("No restaurants available")
            : Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Icon(Icons.restaurant, size: 50),

                      Text(
                        restaurant!['name'],
                        style: const TextStyle(fontSize: 20),
                      ),

                      Text(restaurant!['cuisine'] ?? ""),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}