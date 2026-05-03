// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

// ignore_for_file: file_names

class Meal {
  String name;
  String imgPath;
  List<String> listOfIngredient;
  String? identifier;
  static Meal fromJson(Map<String, dynamic> element) {
Meal mealTMP = Meal(
name: element['strMeal'],
imgPath: element['strMealThumb'],
listOfIngredient: [],
identifier: element['idMeal'],
);
return mealTMP;
}
  
  Meal({
    required this.name,
    required this.imgPath,
    required this.listOfIngredient,
    this.identifier,
  });
  
}
