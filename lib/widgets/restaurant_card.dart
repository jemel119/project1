import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {

  final String name;
  final String cuisine;
  final String priceRange;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.cuisine,
    required this.priceRange,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: ListTile(
        leading: const Icon(Icons.restaurant),
        title: Text(name),
        subtitle: Text("$cuisine • $priceRange"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}