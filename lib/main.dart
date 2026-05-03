import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/singup_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/meals_ofa_day_dart.dart';
import 'package:flutter_application_1/screens/add_new_meal_screen.dart';
import 'package:flutter_application_1/screens/ingredients_of_a_meal_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Meal Planner',
      debugShowCheckedModeBanner: false,
      routes: {
        "HomeScreen": (context) => const HomeScreen(),
        "LoginScreen": (context) => const LoginScreen(),
        "SignupScreen": (context) => const SingUpScreen(),
        "MealsOfADay": (context) => const MealsOfADayScreen(),
        "AddNewMealScreen": (context) => const AddNewMealScreen(),
        "IngredientsOfAMealScreen": (context) => const IngredientsOfAMealScreen(),
      },
      home: const LoginScreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
    );
  }
}
