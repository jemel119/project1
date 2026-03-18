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
    final value = prefs.getDouble('budget');

    setState(() {
      monthlyBudget = value ?? 100;
      controller.text = monthlyBudget.toString();
    });
  }

  Future saveBudget() async {
    final prefs = await SharedPreferences.getInstance();

    double? value = double.tryParse(controller.text);

    if (value == null) return;

    await prefs.setDouble('budget', value);

    setState(() => monthlyBudget = value);
  }

  Future loadSpending() async {
    final total = await DatabaseHelper.instance.getTotalSpending();
    final categories = await DatabaseHelper.instance.getSpendingByCategory();

    setState(() {
      totalSpent = total;
      categoryStats = categories;
    });
  }

  @override
  Widget build(BuildContext context) {

    final remaining = monthlyBudget - totalSpent;

    return Scaffold(
      appBar: AppBar(title: const Text("Food Budget")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Monthly Budget"),
            ),

            ElevatedButton(
              onPressed: saveBudget,
              child: const Text("Save Budget"),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    const Text("Budget Summary",
                        style: TextStyle(fontWeight: FontWeight.bold)),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Spent"),
                        Text("\$${totalSpent.toStringAsFixed(2)}"),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Remaining"),
                        Text(
                          "\$${remaining.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: remaining >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Categories"),

            ...categoryStats.map((c) => Card(
              child: ListTile(
                title: Text(c['category'] ?? "Other"),
                trailing: Text(
                  "\$${(c['total'] as num).toStringAsFixed(2)}",
                ),
              ),
            )),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/expenses');
                loadSpending();
              },
              child: const Text("View Expenses"),
            ),
          ],
        ),
      ),
    );
  }
}