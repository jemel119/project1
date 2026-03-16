import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  String category = "Food";

  Future saveExpense() async {

    if (_formKey.currentState!.validate()) {

      await DatabaseHelper.instance.createExpense({
        'title': titleController.text,
        'amount': double.parse(amountController.text),
        'category': category,
        'date': DateTime.now().toString()
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Expense"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [

              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Expense Title"),
                validator: (value) =>
                    value!.isEmpty ? "Enter expense title" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Enter amount" : null,
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: category,
                items: const [
                  DropdownMenuItem(value: "Food", child: Text("Food")),
                  DropdownMenuItem(value: "Coffee", child: Text("Coffee")),
                  DropdownMenuItem(value: "Dining Out", child: Text("Dining Out")),
                ],
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Category"),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: saveExpense,
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}