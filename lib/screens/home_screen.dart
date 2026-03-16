import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Campus Food Finder"),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/foods');
              },
              child: const Text("Find Food Spots"),
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/budget');
              },
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text("Food Budget"),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
              child: const Text("Favorites"),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/recommend');
              },
                icon: const Icon(Icons.restaurant),
                label: const Text("Smart Recommendation"),
            ),

          ],
        ),
      ),
    );
  }
}