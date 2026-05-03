// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/week_days_card.dart';
import 'package:flutter_application_1/models/meals_of_a_day.dart';
import 'package:flutter_application_1/models/Meal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<MealsOfADay> week_days_List;

  @override
  void initState() {
    super.initState();
    week_days_List = [
      MealsOfADay(
        day: "Monday",
        listOfMealsForADay: [
          Meal(
            name: "Grilled Chicken Salad",
            imgPath: "assets/244dadgumbrisket.webp",
            listOfIngredient: [
              "Chicken breast",
              "Mixed greens",
              "Cherry tomatoes",
              "Cucumber",
              "Olive oil",
            ],
          ),
          Meal(
            name: "Spaghetti Bolognese",
            imgPath: "assets/images.jpg",
            listOfIngredient: [
              "Spaghetti",
              "Ground beef",
              "Tomato sauce",
              "Onion",
              "Garlic",
            ],
          ),
        ],
      ),
      MealsOfADay(
        day: "Tuesday",
        listOfMealsForADay: [
          Meal(
            name: "French Fries",
            imgPath: "assets/Homemade-French-Fries_8.jpg",
            listOfIngredient: ["Potatoes", "Oil", "Salt"],
          ),
        ],
      ),
      MealsOfADay(
        day: "Wednesday",
        listOfMealsForADay: [
          Meal(
            name: "Chelsea Burger",
            imgPath: "assets/chelsea-burger-applewood.jpg",
            listOfIngredient: ["Beef", "Bun", "Cheese", "Lettuce"],
          ),
        ],
      ),
      MealsOfADay(
        day: "Thursday",
        listOfMealsForADay: [
          Meal(
            name: "Django Special",
            imgPath: "assets/django.jpg",
            listOfIngredient: ["Various ingredients"],
          ),
        ],
      ),
      MealsOfADay(day: "Friday", listOfMealsForADay: []),
      MealsOfADay(day: "Saturday", listOfMealsForADay: []),
      MealsOfADay(day: "Sunday", listOfMealsForADay: []),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home Page', style: TextStyle(color: Colors.white)),
        ),
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: week_days_List.length,
        itemBuilder: (context, index) {
          final dayAndItsListOfMeals = week_days_List[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: WeekDaysCard(
              dayAndItsListOfMeals,
              onMealAdded: (meal) {
                setState(() {
                  dayAndItsListOfMeals.listOfMealsForADay.add(meal);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
