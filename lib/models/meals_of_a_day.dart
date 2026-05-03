import 'package:flutter_application_1/models/Meal.dart';

class MealsOfADay {
  final String day;
  final List<Meal> listOfMealsForADay;

  MealsOfADay({
    required this.day,
    required this.listOfMealsForADay,
  });
}
