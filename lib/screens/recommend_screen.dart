import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({super.key});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {

  Map<String, dynamic>? restaurant;

  @override
  void initState() {
    super.initState();
    loadRecommendation();
  }

  Future loadRecommendation() async {

    final r = await DatabaseHelper.instance.getRecommendedRestaurant();

    setState(() {
      restaurant = r;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Recommended Food Spot"),
      ),

      body: Center(

        child: restaurant == null
            ? const Text("No restaurants yet.")
            : Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(
                    restaurant!['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(restaurant!['cuisine'] ?? ""),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: loadRecommendation,
                    child: const Text("Recommend Another"),
                  )
                ],
              ),
      ),
    );
  }
}