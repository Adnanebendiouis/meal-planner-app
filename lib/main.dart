import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 👈 key added

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Meal Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData (appBarTheme: const AppBarTheme (
backgroundColor: Colors.black,
titleTextStyle: TextStyle (color: Colors.orange,
fontSize: 17, fontWeight: FontWeight.bold,),
iconTheme: IconThemeData (color: Colors.orange),),
),
      home: const HomeScreen(),
    );
  }
}


