import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Campus Food Finder")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 30),

            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/foods'),
              icon: const Icon(Icons.restaurant),
              label: const Text("Find Food Spots"),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/budget'),
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text("Food Budget"),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/favorites'),
              icon: const Icon(Icons.favorite),
              label: const Text("Favorites"),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/recommend'),
              icon: const Icon(Icons.lightbulb),
              label: const Text("Smart Recommendation"),
            ),

            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              icon: const Icon(Icons.settings),
              label: const Text("Settings"),
            ),
          ],
        ),
      ),
    );
  }
}