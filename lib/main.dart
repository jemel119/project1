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
  debugShowCheckedModeBanner: false,

  title: "Student Food App",

  theme: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.grey[100],
  ),

  darkTheme: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
  ),

  themeMode: ThemeMode.system,

  initialRoute: '/',
  routes: {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/food_list': (context) => const FoodListScreen(),
    '/add_food': (context) => const AddFoodScreen(),
    '/expenses': (context) => const ExpenseListScreen(),
    '/add_expense': (context) => const AddExpenseScreen(),
    '/recommend': (context) => const RecommendationScreen(),
  },
);
  }
}