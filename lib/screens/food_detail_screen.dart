import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {

  Map<String, dynamic>? restaurant;

  Future loadRestaurant(int id) async {
    final data = await DatabaseHelper.instance.getRestaurant(id);

    setState(() {
      restaurant = data;
    });
  }

  Future toggleFavorite() async {

    int newValue = restaurant!['is_favorite'] == 1 ? 0 : 1;

    await DatabaseHelper.instance.updateRestaurant(
      restaurant!['id'],
      {'is_favorite': newValue},
    );

    loadRestaurant(restaurant!['id']);
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    final id = ModalRoute.of(context)!.settings.arguments as int;

    loadRestaurant(id);
  }

  @override
  Widget build(BuildContext context) {

    if (restaurant == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant!['name']),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Cuisine: ${restaurant!['cuisine']}"),
            Text("Price Range: ${restaurant!['price_range']}"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: toggleFavorite,
              child: const Text("Toggle Favorite"),
            )

          ],
        ),
      ),
    );
  }
}