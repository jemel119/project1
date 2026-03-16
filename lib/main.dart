import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/food_list_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/add_food_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/add_expense_acreen.dart';
import 'screens/recommendation_screen.dart';

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
        '/add_food': (context) => const AddFoodScreen(),
        '/expenses': (context) => const ExpenseListScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
        '/recommend': (context) => const RecommendationScreen(),
      },
    );
  }
}