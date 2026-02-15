import 'package:flutter/material.dart';

class WeekDaysCard extends StatelessWidget {
  final String day;

  const WeekDaysCard(this.day, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.amber,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
        child: Column(
          children: [
            Expanded(child: 
            Align(
              alignment: Alignment.centerLeft,
              child: Text(day,
              style: TextStyle(color: Colors.black, fontSize: 18)
            ),
            ),
            
            ),
            SizedBox(height: 20,),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ IconButton( icon: Icon(Icons.visibility),onPressed: (){},),
              SizedBox(width: 20,),
              IconButton(icon: Icon(Icons.add), onPressed: (){},color:Colors.black, )
                
              ],
              
            )
            )
          ],


      ),
    );
  }
}
