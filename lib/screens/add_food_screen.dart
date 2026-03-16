import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cuisineController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String priceRange = "\$";

  Future saveRestaurant() async {

    if (_formKey.currentState!.validate()) {

      await DatabaseHelper.instance.createRestaurant({
        'name': nameController.text,
        'cuisine': cuisineController.text,
        'price_range': priceRange,
        'open_hours': hoursController.text,
        'notes': notesController.text
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Food Spot"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(

            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Restaurant Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a restaurant name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: cuisineController,
                decoration: const InputDecoration(
                  labelText: "Cuisine Type",
                ),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(

                value: priceRange,

                items: const [
                  DropdownMenuItem(value: "\$", child: Text("\$ Cheap")),
                  DropdownMenuItem(value: "\$\$", child: Text("\$\$ Moderate")),
                  DropdownMenuItem(value: "\$\$\$", child: Text("\$\$\$ Expensive")),
                ],

                onChanged: (value) {
                  setState(() {
                    priceRange = value!;
                  });
                },

                decoration: const InputDecoration(
                  labelText: "Price Range",
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: hoursController,
                decoration: const InputDecoration(
                  labelText: "Open Hours",
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: "Notes",
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: saveRestaurant,
                child: const Text("Save Restaurant"),
              )

            ],
          ),
        ),
      ),
    );
  }
}