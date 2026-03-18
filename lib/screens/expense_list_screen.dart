import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {

  List<Map<String, dynamic>> expenses = [];

  Future loadExpenses() async {
    final data = await DatabaseHelper.instance.getExpenses();
    setState(() => expenses = data);
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Expenses")),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_expense');
          loadExpenses();
        },
        child: const Icon(Icons.add),
      ),

      body: expenses.isEmpty
          ? const Center(child: Text("No expenses yet"))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, i) {

                final e = expenses[i];

                return Card(
                  child: ListTile(
                    title: Text(e['title']),
                    subtitle: Text(e['category']),
                    trailing: Text(
                      "\$${(e['amount'] as num).toStringAsFixed(2)}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}