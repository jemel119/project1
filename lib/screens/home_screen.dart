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

ElevatedButton.icon(
  onPressed: () {
    Navigator.pushNamed(context, '/budget');
  },
  icon: const Icon(Icons.account_balance_wallet),
  label: const Text("Food Budget"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {},
  child: const Text("Favorites"),
),

const SizedBox(height: 16),

ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/analytics');
  },
  child: const Text("Spending Analytics"),
),

ElevatedButton.icon(
  onPressed: () {
    Navigator.pushNamed(context, '/expenses');
  },
  icon: const Icon(Icons.attach_money),
  label: const Text("Track Food Budget"),
)

          ],
        ),
      ),
    );
  }
}