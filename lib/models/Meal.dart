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
