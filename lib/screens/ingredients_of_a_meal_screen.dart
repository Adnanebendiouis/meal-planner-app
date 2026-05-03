import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Meal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IngredientsOfAMealScreen extends StatelessWidget {
  const IngredientsOfAMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMeal =
        ModalRoute.of(context)?.settings.arguments as Meal? ??
        Meal(name: '', imgPath: '', listOfIngredient: []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentMeal.name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pushNamedAndRemoveUntil(
                context,
                "LoginScreen",
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: currentMeal.listOfIngredient.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.food_bank),
            title: Text(currentMeal.listOfIngredient[index]),
          );
        },
      ),
    );
  }
}
