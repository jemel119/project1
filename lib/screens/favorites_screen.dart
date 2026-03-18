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
    final data = await DatabaseHelper.instance.getFavorites();
    setState(() => favorites = data);
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),

      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, i) {

                final r = favorites[i];

                return Card(
                  child: ListTile(
                    title: Text(r['name']),
                    subtitle: Text(r['cuisine']),
                  ),
                );
              },
            ),
    );
  }
}