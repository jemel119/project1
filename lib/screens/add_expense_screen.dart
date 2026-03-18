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

    double? amount = double.tryParse(amountController.text);

    if (titleController.text.isEmpty || amount == null) return;

    await DatabaseHelper.instance.createExpense({
      'title': titleController.text,
      'amount': amount,
      'category': categoryController.text.isEmpty ? "Other" : categoryController.text,
      'date': DateTime.now().toString(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),

            TextField(controller: categoryController, decoration: const InputDecoration(labelText: "Category")),

            const SizedBox(height: 20),

            ElevatedButton(onPressed: saveExpense, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}