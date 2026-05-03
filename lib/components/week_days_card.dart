import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/meals_of_a_day.dart';
import 'package:flutter_application_1/models/Meal.dart';

class WeekDaysCard extends StatelessWidget {
  final MealsOfADay dayAndItsListOfMeals;
  final void Function(Meal)? onMealAdded;

  const WeekDaysCard(this.dayAndItsListOfMeals, {super.key, this.onMealAdded});

  @override
  Widget build(BuildContext context) {
    final mealCount = dayAndItsListOfMeals.listOfMealsForADay.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dayAndItsListOfMeals.day,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$mealCount meal${mealCount == 1 ? '' : 's'}',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "MealsOfADay",
                    arguments: dayAndItsListOfMeals,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    "AddNewMealScreen",
                    arguments: dayAndItsListOfMeals,
                  ).then((result) {
                    if (result != null && result is Meal) {
                      onMealAdded?.call(result);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
