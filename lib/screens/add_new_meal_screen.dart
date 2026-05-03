import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/meal_card.dart';
import 'package:flutter_application_1/components/my_buttons.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/helpers/validators.dart';
import 'package:flutter_application_1/models/Meal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddNewMealScreen extends StatefulWidget {
  const AddNewMealScreen({super.key});

  @override
  State<AddNewMealScreen> createState() => _AddNewMealScreenState();
}

class _AddNewMealScreenState extends State<AddNewMealScreen> {
  final GlobalKey<FormState> keyFormState = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController imgPathController;
  List<TextEditingController> listOfTextField = [];
  Meal? theNewMeal;
  late Future<List<Meal>> _mealsFuture;

  Future<List<Meal>> _fetchMealsFromAPI() async {
    List<Meal> mealListTMP = [];
    final fetchedData = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=p'));
    final decodedData = jsonDecode(fetchedData.body);
    if (decodedData['meals'] != null && decodedData['meals'].isNotEmpty) {
      for (final element in decodedData['meals']) {
        mealListTMP.add(Meal.fromJson(element));
      }
    }
    return mealListTMP;
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    imgPathController = TextEditingController();
    listOfTextField.add(TextEditingController());
    _mealsFuture = _fetchMealsFromAPI();
  }

  @override
  void dispose() {
    nameController.dispose();
    imgPathController.dispose();
    for (var c in listOfTextField) {
      c.dispose();
    }
    super.dispose();
  }

  void displayAToast() {
    Fluttertoast.showToast(
      msg: "Your entries are not valide",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void addIngredientField() {
    setState(() {
      listOfTextField.add(TextEditingController());
    });
  }

  void removeIngredientField() {
    if (listOfTextField.length > 1) {
      setState(() {
        listOfTextField.last.dispose();
        listOfTextField.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Adding a new meal",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: keyFormState,
            child: Column(
              children: [
                const Text(
                  "Select a meal from this list:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 350,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<Meal>>(
                    future: _mealsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text("Failed to load meals"));
                      }
                      if (snapshot.hasData) {
                        final fetchedMealList = snapshot.data!;
                        return GridView.builder(
                          itemCount: fetchedMealList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            return MealCard(
                              meal: fetchedMealList[index],
                              cardIcon: const Icon(Icons.check_box_outline_blank),
                              onDeleteMeal: () {
                                theNewMeal = fetchedMealList[index];
                                Navigator.of(context).pop(theNewMeal);
                              },
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const Text(
                  "Or add your own meal :",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange),
                ),
                SizedBox(height: screenHeight * 0.05),
                MyTextfield(
                  TFHintText: "Enter meals name",
                  TFIcon: const Icon(Icons.restaurant_menu),
                  TFController: nameController,
                  isObscure: false,
                  TFValidator: (val) => emptyValidationFct(val),
                ),
                const SizedBox(height: 12),
                MyTextfield(
                  TFHintText: "Enter image path",
                  TFIcon: const Icon(Icons.image),
                  TFController: imgPathController,
                  isObscure: false,
                  TFValidator: (val) => emptyValidationFct(val),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "List of ingredients",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: removeIngredientField,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: addIngredientField,
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listOfTextField.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: MyTextfield(
                                TFHintText: "Enter ingredient",
                                TFIcon: const Icon(Icons.food_bank),
                                TFController: listOfTextField[i],
                                isObscure: false,
                                TFValidator: (val) => emptyValidationFct(val),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MyElevatedButton(
                  buttonLable: "Add the meal",
                  onPressedFct: () {
                    if (keyFormState.currentState!.validate()) {
                      final listOfIngredient = listOfTextField
                          .map((c) => c.text.trim())
                          .where((s) => s.isNotEmpty)
                          .toList();
                      final newMeal = Meal(
                        name: nameController.text.trim(),
                        imgPath: imgPathController.text.trim(),
                        listOfIngredient: listOfIngredient,
                      );
                      Navigator.pop(context, newMeal);
                    } else {
                      displayAToast();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
