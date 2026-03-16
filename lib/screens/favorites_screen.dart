import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  List<Map<String, dynamic>> favorites = [];

  Future loadFavorites() async {

    final all = await DatabaseHelper.instance.getRestaurants();

    setState(() {
      favorites = all.where((r) => r['is_favorite'] == 1).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),

      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {

          final r = favorites[index];

          return ListTile(
            title: Text(r['name']),
            subtitle: Text(r['cuisine']),
          );
        },
      ),
    );
  }
}