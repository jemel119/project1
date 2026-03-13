import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/food_list_screen.dart';
import 'screens/budget_screen.dart';

void main() {
  runApp(const CampusFoodFinderApp());
}

class CampusFoodFinderApp extends StatelessWidget {
  const CampusFoodFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Food Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/foods': (context) => const FoodListScreen(),
        '/budget': (context) => const BudgetScreen(),
      },
    );
  }
}