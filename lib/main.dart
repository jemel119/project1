import 'package:campus_food_finder/screens/recommend_screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/food_list_screen.dart';
import 'screens/add_food_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/recommend_screen.dart';

void main() {
  runApp(const CampusFoodApp());
}

class CampusFoodApp extends StatelessWidget {
  const CampusFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Food Finder',

      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/foods': (context) => const FoodListScreen(),
        '/add_food': (context) => const AddFoodScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/expenses': (context) => const ExpenseListScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/recommend': (context) => const RecommendationScreen(),
      },
    );
  }
}