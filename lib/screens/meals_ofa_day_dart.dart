import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/meals_of_a_day.dart';
import 'package:flutter_application_1/components/meal_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/Meal.dart';

class MealsOfADayScreen extends StatefulWidget {
  const MealsOfADayScreen({super.key});

  @override
  State<MealsOfADayScreen> createState() => _MealsOfADayScreenState();
}

class _MealsOfADayScreenState extends State<MealsOfADayScreen> {
  late List<Meal> _meals;
  late MealsOfADay _dayData;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _dayData = ModalRoute.of(context)?.settings.arguments as MealsOfADay? ??
          MealsOfADay(day: '', listOfMealsForADay: []);
      _meals = List<Meal>.from(_dayData.listOfMealsForADay);
      _initialized = true;
    }
  }

  void _deleteMeal(int index) {
    final removed = _meals[index];
    setState(() {
      _meals.removeAt(index);
    });
    _dayData.listOfMealsForADay.remove(removed);
  }

  @override
  Widget build(BuildContext context) {
    if (_dayData.day.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Meals of the day')),
        body: const Center(child: Text('No data')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details page for ${_dayData.day}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                "LoginScreen",
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: _meals.isEmpty
          ? const Center(child: Text('No meals for this day'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                return MealCard(
                  meal: _meals[index],
                  cardIcon: const Icon(Icons.delete, color: Colors.red),
                  onDeleteMeal: () => _deleteMeal(index),
                );
              },
            ),
    );
  }
}
