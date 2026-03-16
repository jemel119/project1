import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/food_list_screen.dart';
import 'screens/add_food_screen.dart';
import 'screens/food_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/recommend_screen.dart';

void main() {
  runApp(const CampusFoodApp());
}

class CampusFoodApp extends StatelessWidget {
  const CampusFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Campus Food Finder",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/foods': (context) => const FoodListScreen(),
        '/add_food': (context) => const AddFoodScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/expenses': (context) => const ExpenseListScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/food_detail': (context) => const FoodDetailScreen(),
        '/recommend': (context) => const RecommendScreen(),
      },
    );
  }
}