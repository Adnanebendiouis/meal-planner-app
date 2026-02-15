import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/week_days_card.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  final List<String> weekDays = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Home Page', style: TextStyle(color: Colors.white)),),
      actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){})],
      
      ),
      body: ListView.builder(scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: weekDays.length,
      itemBuilder: (context, index) {
                  return Padding(
            padding: const EdgeInsets.all(8),
            child: WeekDaysCard(weekDays[index]), 
          );
      }
      ),
      
    );
  }
}