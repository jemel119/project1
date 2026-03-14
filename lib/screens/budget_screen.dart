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

  final TextEditingController budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadBudget();
    loadSpending();
  }

  Future loadBudget() async {

    final prefs = await SharedPreferences.getInstance();
    double? savedBudget = prefs.getDouble('monthly_budget');

    setState(() {
      monthlyBudget = savedBudget ?? 100;
      budgetController.text = monthlyBudget.toString();
    });
  }

  Future saveBudget() async {

    final prefs = await SharedPreferences.getInstance();

    double value = double.parse(budgetController.text);

    await prefs.setDouble('monthly_budget', value);

    setState(() {
      monthlyBudget = value;
    });
  }

  Future loadSpending() async {

    final total = await DatabaseHelper.instance.getTotalSpending();

    setState(() {
      totalSpent = total;
    });
  }

  @override
  Widget build(BuildContext context) {

    double remaining = monthlyBudget - totalSpent;
    double progress = totalSpent / monthlyBudget;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Food Budget"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Monthly Budget",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Set Budget",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: saveBudget,
              child: const Text("Save Budget"),
            ),

            const SizedBox(height: 30),

            Text(
              "Total Spent: \$${totalSpent.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Remaining: \$${remaining.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                color: remaining < 0 ? Colors.red : Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              minHeight: 12,
            ),

            const SizedBox(height: 20),

            if (remaining < 0)
              const Text(
                "⚠️ You are over budget!",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/expenses').then((_) {
                  loadSpending();
                });
              },
              icon: const Icon(Icons.list),
              label: const Text("View Expenses"),
            ),

          ],
        ),
      ),
    );
  }
}