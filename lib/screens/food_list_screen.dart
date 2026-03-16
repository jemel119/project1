import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {

  List<Map<String, dynamic>> restaurants = [];
  List<Map<String, dynamic>> filtered = [];

  final searchController = TextEditingController();

  Future loadRestaurants() async {

    final data = await DatabaseHelper.instance.getRestaurants();

    setState(() {
      restaurants = data;
      filtered = data;
    });
  }

  void search(String text) {

    setState(() {

      filtered = restaurants.where((r) {

        final name = r['name'].toLowerCase();

        return name.contains(text.toLowerCase());

      }).toList();

    });
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Spots"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_food');
          loadRestaurants();
        },
        child: const Icon(Icons.add),
      ),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search restaurants",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: search,
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {

                final r = filtered[index];

                return ListTile(
                  title: Text(r['name']),
                  subtitle: Text(r['cuisine'] ?? ""),
                  trailing: Icon(
                    r['is_favorite'] == 1
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}