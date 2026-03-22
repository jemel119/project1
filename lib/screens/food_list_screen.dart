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

  final searchController = TextEditingController();
  String selectedCuisine = "All";

  Future loadRestaurants() async {
    final data = await DatabaseHelper.instance.getRestaurants();
    setState(() => restaurants = data);
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  // 🔍 FILTER LOGIC
  List<Map<String, dynamic>> filteredRestaurants() {
    return restaurants.where((r) {
      final name = (r['name'] ?? "").toLowerCase();
      final cuisine = (r['cuisine'] ?? "");

      final matchesSearch =
          name.contains(searchController.text.toLowerCase());

      final matchesCuisine =
          selectedCuisine == "All" || cuisine == selectedCuisine;

      return matchesSearch && matchesCuisine;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    final filtered = filteredRestaurants();

    return Scaffold(
      appBar: AppBar(title: const Text("Food Spots")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_food');
          loadRestaurants();
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            // 🔍 SEARCH BAR
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search restaurants",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),

            const SizedBox(height: 10),

            //  FILTER DROPDOWN
            DropdownButtonFormField<String>(
              initialValue: selectedCuisine,
              decoration: InputDecoration(
                labelText: "Filter by Cuisine",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: ["All", "Fast Food", "Asian", "American", "Other"]
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCuisine = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            //  LIST
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("No matching restaurants"))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {

                        final r = filtered[i];

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,

                          child: ListTile(
                            title: Text(r['name']),
                            subtitle: Text(r['cuisine'] ?? ""),

                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      FoodDetailScreen(restaurant: r),
                                ),
                              );

                              loadRestaurants();
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
            ),
          ],
        ),
      ),
    );
  }
}