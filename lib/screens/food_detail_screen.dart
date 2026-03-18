import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class FoodDetailScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const FoodDetailScreen({super.key, required this.restaurant});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {

  late TextEditingController notesController;
  late int isFavorite;

  @override
  void initState() {
    super.initState();

    notesController =
        TextEditingController(text: widget.restaurant['notes'] ?? "");

    isFavorite = widget.restaurant['is_favorite'] ?? 0;
  }

  Future updateRestaurant() async {

    await DatabaseHelper.instance.updateRestaurant(
      widget.restaurant['id'],
      {
        'name': widget.restaurant['name'],
        'cuisine': widget.restaurant['cuisine'],
        'price_range': widget.restaurant['price_range'],
        'open_hours': widget.restaurant['open_hours'],
        'notes': notesController.text,
        'is_favorite': isFavorite,
      },
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Updated successfully")),
    );
  }

  Future deleteRestaurant() async {

    await DatabaseHelper.instance
        .deleteRestaurant(widget.restaurant['id']);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant['name']),

        actions: [

          IconButton(
            icon: Icon(
              isFavorite == 1
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                isFavorite = isFavorite == 1 ? 0 : 1;
              });
              updateRestaurant();
            },
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteRestaurant,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              widget.restaurant['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text("Cuisine: ${widget.restaurant['cuisine']}"),
            Text("Price: ${widget.restaurant['price_range']}"),

            const SizedBox(height: 20),

            const Text(
              "Notes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Add notes...",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateRestaurant,
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}