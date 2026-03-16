import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {

  final nameController = TextEditingController();
  final cuisineController = TextEditingController();
  final priceController = TextEditingController();

  Future<void> saveRestaurant() async {

    // Prevent saving empty restaurants
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Restaurant name is required")),
      );
      return;
    }

    final restaurant = {
      'name': nameController.text,
      'cuisine': cuisineController.text,
      'price_range': priceController.text,
      'open_hours': '',
      'notes': '',
      'is_favorite': 0,
    };

    await DatabaseHelper.instance.createRestaurant(restaurant);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food Spot"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: cuisineController,
              decoration: const InputDecoration(labelText: "Cuisine"),
            ),

            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price Range"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await saveRestaurant();
              },
              child: const Text("Save"),
            )

          ],
        ),
      ),
    );
  }
}