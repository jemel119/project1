import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Campus Food Finder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/foods');
  },
  child: const Text("Find Food Spots"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/budget');
  },
  child: const Text("Budget Tracker"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/favorites');
  },
  child: const Text("Favorites"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/recommend');
  },
  child: const Text("Food Recommendation"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/analytics');
  },
  child: const Text("Spending Analytics"),
),

          ],
        ),
      ),
    );
  }
}