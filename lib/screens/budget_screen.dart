import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetScreen extends StatefulWidget {

  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {

  double monthlyBudget = 100;
  double totalSpent = 0;

  List<Map<String, dynamic>> categoryStats = [];

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadBudget();
    loadSpending();
  }

  Future loadBudget() async {

    final prefs = await SharedPreferences.getInstance();

    double? value = prefs.getDouble('budget');

    setState(() {
      monthlyBudget = value ?? 100;
      controller.text = monthlyBudget.toString();
    });
  }

  Future saveBudget() async {

    final prefs = await SharedPreferences.getInstance();

    double value = double.parse(controller.text);

    await prefs.setDouble('budget', value);

    setState(() {
      monthlyBudget = value;
    });
  }

  Future loadSpending() async {

    final total = await DatabaseHelper.instance.getTotalSpending();

    final categories =
        await DatabaseHelper.instance.getSpendingByCategory();

    setState(() {
      totalSpent = total;
      categoryStats = categories;
    });
  }

  @override
  Widget build(BuildContext context) {

    double remaining = monthlyBudget - totalSpent;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Food Budget"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(

          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Monthly Budget",
              ),
            ),

            ElevatedButton(
              onPressed: saveBudget,
              child: const Text("Save Budget"),
            ),

            const SizedBox(height: 20),

            Text("Total Spent: \$${totalSpent.toStringAsFixed(2)}"),

            Text("Remaining: \$${remaining.toStringAsFixed(2)}"),

            const SizedBox(height: 20),

            const Text(
              "Spending by Category",
              style: TextStyle(fontSize: 18),
            ),

            ...categoryStats.map((c) => ListTile(
                  title: Text(c['category'] ?? "Other"),
                  trailing: Text("\$${c['total']}"),
                )),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/expenses')
                    .then((_) => loadSpending());
              },
              child: const Text("View Expenses"),
            )
          ],
        ),
      ),
    );
  }
}