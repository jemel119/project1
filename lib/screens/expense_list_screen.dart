import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {

  List<Map<String, dynamic>> expenses = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future loadExpenses() async {

    final data = await DatabaseHelper.instance.getExpenses();
    final totalAmount = await DatabaseHelper.instance.getTotalSpending();

    setState(() {
      expenses = data;
      total = totalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Food Budget Tracker"),
      ),

      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total Spent: \$${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {

                final expense = expenses[index];

                return ListTile(
                  title: Text(expense['title']),
                  subtitle: Text(expense['category']),
                  trailing: Text("\$${expense['amount']}"),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_expense').then((_) {
            loadExpenses();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}