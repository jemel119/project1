import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

  Future saveExpense() async {

    final expense = {
      'title': titleController.text,
      'amount': double.parse(amountController.text),
      'category': categoryController.text,
      'date': DateTime.now().toString(),
    };

    await DatabaseHelper.instance.createExpense(expense);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveExpense,
              child: const Text("Save"),
            )

          ],
        ),
      ),
    );
  }
}